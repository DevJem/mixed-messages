# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "mixed-messages"
set :repo_url, "git@bitbucket.org:DevJem/mixed-messages.git"

# set :unicorn_config_path, "/etc/default/unicorn"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name

# Default value for :format is :airbrussh.
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :deploy_to, "/home/rails/"
set :group, "deployers"


set :use_sudo, false
set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

desc "Symlink shared config files"
task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/secrets.yml #{ current_path }/config/secrets.yml"
end

# after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
  task :execute_on_server do
  	on "deployer@67.205.184.235" do
  		execute "sudo service unicorn restart"
  end
end

# namespace :deploy do
#   task :restart do
#     invoke 'unicorn:reload'
#   end
# end