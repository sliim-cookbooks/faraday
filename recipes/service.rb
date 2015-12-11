# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Recipe:: service
#
# Copyright 2015, Sliim
#

include_recipe 'faraday'

user 'faraday' do
  home node['faraday']['install_dir']
  comment 'Faraday system user'
  supports manage_home: false
  system true
end

faraday_config 'faraday' do
  home node['faraday']['install_dir']
  file 'config.xml'
end

template "/etc/default/#{node['faraday']['service']['NAME']}" do
  source 'service/default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[#{node['faraday']['service']['NAME']}]", :delayed
end

template "/etc/init.d/#{node['faraday']['service']['NAME']}" do
  source 'service/init.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, "service[#{node['faraday']['service']['NAME']}]", :delayed
end

service node['faraday']['service']['NAME'] do
  action [:enable, :start]
  supports status: true, start: true, stop: true, restart: true
end

execute 'systemctl-daemon-reload' do
  action :nothing
  command 'systemctl daemon-reload'
  only_if { node['init_package'] == 'systemd' }
  subscribes :run,
             "template[/etc/init.d/#{node['faraday']['service']['NAME']}]",
             :immediately
end

execute "chown -R faraday #{node['faraday']['install_dir']}"
