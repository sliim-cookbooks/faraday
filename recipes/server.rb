# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Recipe:: server
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

faradir = node['faraday']['install_dir']

with_run_context :root do
  find_resource(:service, 'faraday-server') do
    action :nothing
  end
end

template "#{faradir}/server/www/config/config.json" do
  owner node['faraday']['user']
  group node['faraday']['user']
  source 'server/config.json.erb'
  variables server_config: node['faraday']['server']['www']
  notifies :restart, 'service[faraday-server]', :delayed
end

directory "#{node['faraday']['home']}/.faraday/config" do
  owner node['faraday']['user']
  group node['faraday']['user']
  recursive true
end

template "#{node['faraday']['home']}/.faraday/config/server.ini" do
  owner node['faraday']['user']
  group node['faraday']['user']
  source 'server/config.ini.erb'
  variables server_config: node['faraday']['server']['config']
  notifies :restart, 'service[faraday-server]', :delayed
end

if node.recipe? 'faraday::sources'
  pip_requirements "#{faradir}/requirements_server.txt" do
    python node['faraday']['python_runtime']
    virtualenv 'faraday-venv'
  end
end
