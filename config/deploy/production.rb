set :deploy_to, "/home/#{user}/rails_apps/#{application}/prod"

namespace :public do
  task :symlink_prod do
    run "rm -f #{www}#{sym_link_to_public}"
    run "ln -sf #{current_path}/public #{www}#{sym_link_to_public}"
  end
end

after "deploy", "public:symlink_prod"