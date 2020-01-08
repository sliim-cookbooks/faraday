# -*- coding: utf-8 -*-
#
# Cookbook:: faraday
# Recipe:: service
# Copyright:: 2015-2020 Sliim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

user 'faraday' do
  home node['faraday']['install_dir']
  comment 'Faraday system user'
  manage_home false
  system true
end

group 'faraday' do
  members ['faraday']
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

execute "chown -R faraday:faraday #{node['faraday']['install_dir']}"
