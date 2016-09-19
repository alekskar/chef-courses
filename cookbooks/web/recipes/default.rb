#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#install nginx web server
package 'nginx' do
  action :install
end

#copy nginx config with predefined parameters 
#nginx port
#tomcat port
#jenkins port
#jenkins prefix
template '/etc/nginx/conf.d/default.conf' do
  source 'default.conf.erb'
  variables({
  :nginx_port => node['nginx']['port'],
  :jenkins_port => node['jenkins']['port'],
  :tomcat_port => node['tomcat']['port'],
  :jenkins_prefix => node['jenkins']['prefix']
  })
end

#enable nginx runnable after reload and start service

service 'nginx' do
  action [ :enable, :start]
end
