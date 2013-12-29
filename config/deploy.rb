require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'

#set :stages, %w(staging production)
#set :default_stage, 'staging'

load 'config/deploy/custom.rb'

set :application, 'memorizr'
set :repository, 'gitolite@jarra.nl:memorizr.git'

load 'deploy/assets'

set :keep_releases, 5
#after 'deploy:update', 'deploy:cleanup' 

set :scm, :git

set :rvm_ruby_string, 'ruby-1.9.3-p484'
set :rvm_type, :system

before 'deploy:finalize_update', 'deploy:symlink_config_files'

load 'config/deploy_with_monit.rb'
