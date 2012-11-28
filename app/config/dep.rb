# deploy.rb
require "capistrano_colors"

set   :application,   "itsol_app"
set   :deploy_to,     "/home/ec2-user/itsol2"

default_run_options[:pty] = true
set   :scm,           :git
set   :repository,    "git@github.com:road-to-dai/Symfony.git"
set   :deploy_via,    :copy


set :ssh_options, {:forward_agent => true}
set :user, "ec2-user"
set :domain, "ec2-176-34-3-59.ap-northeast-1.compute.amazonaws.com"
ssh_options[:keys] = ["/root/aws/itsol.pem"]


set :model_manager, "doctrine"
set :deploy_via, :remote_cache

# Or: `propel`

role :web, domain # Your HTTP server, Apache/etc
role :app, domain # This may be the same as your `Web` server
role :db, domain, :primary => true # This is where Symfony2 migrations will run

set :keep_releases, 3

set :use_composer, true
set :update_vendors, true

set :shared_files, ["app/config/parameters.yml", "composer.phar"]
set :shared_children, [app_path + "/logs", web_path + "/uploads", "vendor"]

set :use_sudo, true

set :writable_dirs, ["app/cache", "app/logs"]
set :webserver_user, "www"
set :permission_method, :chown

set :dump_assetic_assets, true
# Be more verbose by uncommenting the following line
logger.level = Logger::MAX_LEVEL


after "deploy:setup" do
  "#{sudo} touch /home/ec2-user/test-abc.txt"
end

after "deploy:update" do
  run "#{sudo} chmod -R 777 #{deploy_to}/current/app/cache #{deploy_to}/current/app/cache"
end

