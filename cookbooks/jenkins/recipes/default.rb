#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2016, epam 
#
# All rights reserved - Do Not Redistribute
#
#
#
# create jenkins user to manage jenkins
user 'jenkins' do
  comment 'jenkins_system_user'
  home '/home/jenkins'
  supports :manage_home => true
  action :create
end

# adding jenkins repo to have latest jenkins version
execute 'install_repo' do
command <<-EOF
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
    EOF
end

#installing jenkins and git to work with git plugin
package ['jenkins', 'git'] do
  action :install
end

#replace default config with custom 
#two attributes can be changed
#jenkins port and jenkins prefix
template '/etc/sysconfig/jenkins' do
  source 'jenkins.erb'
  mode '0755'
  variables({
  	:jenkins_port => node['jenkins']['port'],
  	:jenkins_prefix => node['jenkins']['prefix']
  	})
end
#copy jenkins config file with predifined aliaksandr_karavai pipeline
#and without authentification
cookbook_file '/var/lib/jenkins/config.xml' do
  source 'jenkinsconfig'
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
end
#copy build tools config to define Maven version
#jenkins download jenkins plugin itself
cookbook_file '/var/lib/jenkins/hudson.tasks.Maven.xml' do
  source 'hudson.tasks.Maven.xml'
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
end
#copy jobs folders with two predifines jobs and pipeline
remote_directory '/var/lib/jenkins/jobs' do
  source 'jobs'
  mode '0755'
  action :create
end
# copy all nesessary plygins to jenkins folder to make it possible run a build
remote_directory '/var/lib/jenkins/plugins' do
  action :create
end
# set proper rights on system folders
execute 'chown_jenkins' do
  command 'chown -R jenkins:jenkins /var/lib/jenkins'
end
# start jenkins and add to chkconfig
service 'jenkins' do
  action [:start, :enable]
end
