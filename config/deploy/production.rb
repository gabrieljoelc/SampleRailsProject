set :deploy_to, "/home/#{user}/rails_apps/#{application}/prod"
set :www, "~/public_html" # NO, TRAILING SLASH, PLEASE
# symbolic link directory. must have leading slash (i.e. if desired is ~/public_html/railsapp, then use /railsapp)
set :symlink_to_public, "/baradesigncompany" # NO, TRAILING SLASH, PLEASE

namespace :public do
  task :symlink_prod do
    run "rm -f #{www}#{symlink_to_public}"
    run "ln -sf #{current_path}/public #{www}#{symlink_to_public}"
  end
end

after "deploy", "public:symlink_prod"