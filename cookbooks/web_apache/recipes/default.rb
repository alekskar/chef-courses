#
# Cookbook Name:: web_apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
web "apache" do
  provider "web_apache"
  action [ :install_server, :start ]
  
end

