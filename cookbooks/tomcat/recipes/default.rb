#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2016, epam company 
#
# All rights reserved - Do Not Redistribute
#
#install java with predifined wersion
package node['java']['version'] do
  action :install
end
#
#install tomcat and webapps
package ['tomcat', 'tomcat-webapps'] do
  action :install
end
#copy tomcat config file from template
#parameter listening tomcat port is a variable
template '/etc/tomcat/server.xml' do
  source 'server.xml.erb'
  variables({
    :tomcat_port => node['tomcat']['port']
    })
  end
# change rights to jenkins and tomcat deploy  folder
execute 'chown' do
  command <<-EOF
  chown -R jenkins:jenkins /var/lib/tomcat/webapps
  chmod -R 777 /var/lib/tomcat/webapps
  EOF
end
# starting tomcat service and make it available
# after rebooting
service 'tomcat' do
  action [ :enable, :start]
end
