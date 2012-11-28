# deploy.rb
require "capistrano_colors"

set   :application,   "itsol_app"
set   :deploy_to,     "/home/ec2-user/itsol"
#set   :domain,        "dev.myfirm.com"

default_run_options[:pty] = true

set   :scm,           :git
set   :repository,    "git@github.com:road-to-dai/Symfony.git"
set   :deploy_via,    :copy


set :ssh_options, {:forward_agent => true}

set :user, "ec2-user"
set :domain, "ec2-176-34-3-59.ap-northeast-1.compute.amazonaws.com"
ssh_options[:keys] = ["/root/aws/itsol.pem"]


role  :web,           domain
role  :app,           domain
role  :db,            domain, :primary => true

set   :use_sudo,      false
set   :keep_releases, 3

set :shared_files,      ["app/config/parameters.ini"]
set :shared_children,   [app_path + "/logs", web_path + "/uploads", "vendor"]
#set :update_vendors, true

