set :deploy_to, "/home/#{user}/rails_apps/#{application}/stag"
set :www, "~/public_html" # NO, TRAILING SLASH, PLEASE
# symbolic link directory. must have leading slash (i.e. if desired is ~/public_html/railsapp, then use /railsapp)
set :symlink_to_public, "/baradesigncompany" # NO, TRAILING SLASH, PLEASE
set :rails_env, "staging"

namespace :public do
  task :symlink_stag do
    run "rm -f #{www}#{symlink_to_public}"
    run "ln -sf #{current_path}/public #{www}#{symlink_to_public}"
  end
end

after "deploy", "public:symlink_stag"