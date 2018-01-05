lock '3.8.2'

set :application, 'post-2020-timeline'
set :repo_url, 'git@github.com:unepwcmc/post-2020-timeline.git'


set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v9.0.0'
set :nvm_map_bins, %w{node npm yarn}



# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp


set :deploy_user, 'wcmc'


set :backup_path, "/home/#{fetch(:deploy_user)}/Backup"



# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git
set :scm_username, "unepwcmc-read"


set :rvm_type, :user
set :rvm_ruby_version, '2.4.1'



set :ssh_options, {
  forward_agent: true,
}


# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
#set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_files, %w{config/database.yml .env} 

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'node_modules', 'client/node_modules')


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :passenger_restart_with_touch, false
