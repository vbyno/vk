# config valid only for Capistrano 3.4
lock '3.4.0'

application = 'vk'
user_name = 'vbyno'
rvm_ruby_string = 'ruby-2.2.2@vk'

set :application, application
set :repo_url, 'git@github.com:vbyno/vk.git'
set :rvm_type, :user
set :rvm_ruby_version, rvm_ruby_string
set :deploy_to, "/var/www/apps/#{application}"
set :sudo, 'env rvmsudo_secure_path=1 rvmsudo'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
# Default value for :format is :pretty
# set :format, :pretty
# Default value for :log_level is :debug
# set :log_level, :debug
# Default value for :pty is false
# set :pty, true
# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :ssh_options, { forward_agent: true, port: port }
# Default value for keep_releases is 5
set :keep_releases, 5

namespace :foreman do
  desc 'Start server'
  task :start do
    on roles(:all) do
      sudo "start #{application}"
    end
  end

  desc 'Stop server'
  task :stop do
    on roles(:all) do
      sudo "stop #{application}"
    end
  end

  desc 'Restart server'
  task :restart do
    on roles(:all) do
      sudo "restart #{application}"
    end
  end

  desc 'Server status'
  task :status do
    on roles(:all) do
      execute "initctl list | grep #{application}"
    end
  end
end

namespace :git do
  desc 'Deploy'
  task :deploy do
    ask(:message, "Commit message?")
    run_locally do
      execute "git add -A"
      execute "git commit -m '#{fetch(:message)}'"
      execute "git push"
    end
  end
end

namespace :deploy do
  desc 'Setup'
  task :setup do
    on roles(:all) do
      execute "mkdir -p #{shared_path}/config/"
      execute "mkdir -p /var/www/apps/#{application}/run/"
      execute "mkdir -p /var/www/apps/#{application}/log/"
      execute "mkdir -p /var/www/apps/#{application}/socket/"
      execute "mkdir -p #{shared_path}/system"

      execute "rm -f /var/www/log/upstart"
      sudo "ln -sf /var/log/upstart /var/www/log/upstart"

      upload!('config/application.yml', "#{shared_path}/config/application.yml")
      upload!('config/database.yml',    "#{shared_path}/config/database.yml")
      upload!('config/redis.yml',       "#{shared_path}/config/redis.yml")
      upload!('shared/Procfile',        "#{shared_path}/Procfile")

      # Commented this because several sites will be stored on one nginx server
      # so before first deploy of new app fix nginx.conf by hands
      # sudo 'stop nginx'
      # sudo "rm -f /usr/local/nginx/conf/nginx.conf"
      # sudo "ln -s #{shared_path}/nginx.conf /usr/local/nginx/conf/nginx.conf"
      # sudo 'start nginx'

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end
    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      execute "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
      execute "ln -s #{shared_path}/config/database.yml    #{release_path}/config/database.yml"
      execute "ln -s #{shared_path}/config/redis.yml       #{release_path}/config/redis.yml"
      execute "ln -s #{shared_path}/Procfile               #{release_path}/Procfile"
      execute "ln -s #{shared_path}/system                 #{release_path}/public/system"
      execute "ln -s #{shared_path}/public/uploads         #{release_path}/public/uploads"
    end
  end

  desc 'Foreman init'
  task :foreman_init do
    on roles(:all) do
      foreman_temp = "/var/www/tmp/foreman"
      execute  "mkdir -p #{foreman_temp}"
      # Create folder for foreman be able to create upstart-files with correct paths
      execute "ln -s #{release_path} #{current_path}"

      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec foreman export upstart #{foreman_temp} -a #{application} -u #{user_name} -l /var/www/apps/#{application}/log -d #{current_path}"
      end
      sudo "mv #{foreman_temp}/* /etc/init/"
      sudo "rm -r #{foreman_temp}"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "restart #{application}"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

  after :updating, 'deploy:symlink'
  after :setup, 'deploy:foreman_init'

  after :foreman_init, 'foreman:start'
  before :foreman_init, 'rvm:hook'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'
end
