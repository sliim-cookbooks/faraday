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
end

template "#{node['faraday']['install_dir']}/server" do
  source 'service/server.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/default/faraday' do
  source 'service/default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[faraday]', :delayed
end

template '/etc/init.d/faraday' do
  source 'service/init.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[faraday]', :delayed
end

service 'faraday' do
  action [:enable, :start]
  supports status: true, start: true, stop: true, restart: true
end

execute 'systemctl-daemon-reload' do
  action :nothing
  command 'systemctl daemon-reload'
  subscribes :run, 'template[/etc/init.d/faraday]', :immediately
  only_if { node['init_package'] == 'systemd' }
end

execute "chown -R faraday #{node['faraday']['install_dir']}"
