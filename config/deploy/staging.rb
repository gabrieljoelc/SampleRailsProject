set :deploy_to, "/home/#{user}/rails_apps/#{application}/stag"
set :rails_env, "staging"

namespace :public do
  task :symlink_stag do
    run "rm -f #{www}#{sym_link_to_public}"
    run "ln -sf #{current_path}/public #{www}#{sym_link_to_public}"
  end
end

after "deploy", "public:symlink_stag"