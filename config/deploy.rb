# config valid only for Capistrano 3.2
lock '3.2.1'

set :application, 'cappp'
set :repo_url, 'git@github.com:qw3r/cappp.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/cappper/app'

# Default value for :scm is :git
# set :scm, :git

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

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'


namespace :deploy do
  after :publishing, :restart

  desc 'Start application'
  task :start do
    on roles(:app) do
      within release_path do
        execute :bundle, :exec, "rackup -D"
      end
    end
  end


  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute :killall, "-9 ruby; true"
      execute :true
    end
  end


  desc 'Restart application'
  task :restart do
    invoke 'deploy:stop'
    invoke 'deploy:start'
  end

end
