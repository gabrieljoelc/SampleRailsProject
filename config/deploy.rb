set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'erb'

#############################################################
#	Servers
#############################################################

set :user, "gabriel"
set :domain, "67.228.141.105"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Application
#############################################################

set :application, "BaraDesignCompany"
set :deploy_via, :checkout
#set :deploy_via, :remote_cache

#############################################################
#	Database
#############################################################
#set :db_host, "DB host name"
#set :db_user, "DB user name"
#set :db_prefix, "any DB name prefix your host might require"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, false
set :chmod755, %w(app config db lib public vendor script tmp public/javascripts public/stylesheets public/images)
# By default, Capistrano makes the release group-writable. You don't want this with HostingRails
set :group_writable, false
# default behavior is to flush page cache on deploy
set :flush_cache, true

#############################################################
#	Subversion
#############################################################

if variables.include?(:branch)
  set :repository, "svn+ssh://#{user}@#{domain}/home/#{user}/svn/#{application}/branches/#{branch}"
else
  set :repository, "svn+ssh://#{user}@#{domain}/home/#{user}/svn/#{application}/trunk"
end
set :checkout, "export"

#############################################################
#	Methods
#############################################################

def prompt_with_default(var, default)
  set(var) do
    Capistrano::CLI.ui.ask "Enter #{var} [#{default}] : "
  end

  set var, default if eval("#{var.to_s}.empty?")
end


#############################################################
#	Tasks
#############################################################

before "deploy:setup", :db
after "deploy:setup", "caching:create_page_cache"
after "deploy:setup", "caching:mk_asset_dirs"
after "deploy:update_code", "db:symlink"
after :deploy, "deploy:cleanup"
before "deploy:restart", "caching:rm_and_mk_asset_dirs"
before "deploy:restart", "caching:symlink_shared_dirs"

#	Database
namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    prompt_with_default(:db_password, "")
    db_config = ERB.new <<-EOF
    base: &base
      adapter: sqlite3
      pool: 5
      timeout: 5000

    development:
      database: db/development.db
      <<: *base

    test:
      <<: *base

    production:
      database: db/production.db
      <<: *base
      
    staging:
      database: db/staging.db
      <<: *base
    EOF

    run "mkdir -p #{shared_path}/config" 
    put db_config.result, "#{shared_path}/config/database.yml" 
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
end

# page cache management
task :keep_page_cache do
  set :flush_cache, false
end

namespace :caching do
  desc "Remove (if flush_cache true) asset cache directories"
  task :rm_asset_dirs do
    if flush_cache
      run "rm -rf #{current_path}/public/javascripts/cache"
      run "rm -rf #{current_path}/public/stylesheets/cache"
    end
  end
  
  desc "Create asset cache directories"
  task :mk_asset_dirs do
    run "mkdir #{current_path}/public/javascripts/cache"
    run "mkdir #{current_path}/public/stylesheets/cache"
  end
  
  desc "Create page cache directory in shared directory"
  task :create_page_cache, :roles => :app do
    run "umask 02 && mkdir -p #{shared_path}/cache"
  end
  
  desc "Remove (if flush_cache true) and then create asset cache directories"
  task :rm_and_mk_asset_dirs do
    rm_asset_dirs
    mk_asset_dirs
  end
  
  desc "Remove (if flush_cache true) contents of page cache directory"
  task :flush_page_cache, :roles => :app do
    if flush_cache
      run <<-CMD
        rm -rf #{shared_path}/cache/*
      CMD
    end
  end
  
  desc "Create symlink from shared cache directory to public cache symbolic directory"
  task :symlink_shared_dirs, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
    run <<-CMD
      cd #{current_path} &&
      ln -nfs #{shared_path}/cache #{release_path}/public/cache
    CMD
  end
end

#	Passenger
namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    passenger.restart
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do
      passenger.restart
    end
  end
end

desc "Sets permissions for directories and files on the server and set public symlink"
task :after_deploy, :roles => [:app, :db, :web] do
  run(chmod755.collect do |item|
    "chmod 755 #{current_path}/#{item}"
  end.join(" && "))
end