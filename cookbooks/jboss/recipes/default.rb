#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved
#
#include_recipe 'java'

user node['jboss']['user'] do
  comment 'Jboss_system_user'
  manage_home true
  system true
  shell '/bin/bash'
  action :create
end

remote_file node['jboss']['dist_name'] do
  source node['jboss']['url']
  action :create_if_missing
  mode '0755'
end

remote_file node['jboss']['app_path'] do
  source node['jboss']['app_url']
  action :create_if_missing
  mode '0755'
end


yum_package 'unzip' do
  action :install
end

execute 'unzip_jboss' do
  cwd node['jboss']['install_folder']
  command 'unzip jboss7.zip'
  not_if { ::File.directory?("#{node[:jboss][:jboss_home]}")}
end

execute 'change_owner_to_jboss' do
  command "chown -R #{node['jboss']['user']}:#{node['jboss']['user']} #{node['jboss']['jboss_home']}"
end

execute 'unzip_app' do
  cwd node['jboss']['install_folder']
  user node['jboss']['user']
  group node['jboss']['user']
  command "unzip testweb.zip -d #{node['jboss']['deploy_folder']}"
  not_if { ::File.directory?("#{node[:jboss][:deploy_folder]}/testweb")}
end
  template "/etc/init.d/jboss" do
  source "jboss_init_script.erb"
  mode "0755"
  variables({
    :home => node[:jboss][:jboss_home],
    :ip => node[:jboss][:jboss_ip],
    :user => node[:jboss][:user]
})
end

service "jboss" do
  supports :start => true, :stop => true
  action [ :enable, :start ]
end


