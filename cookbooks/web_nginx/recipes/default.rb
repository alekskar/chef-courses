#
# Cookbook Name:: web_nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
web "nginx" do
  provider "web_nginx"
  action [ :install_server, :start ]
end
