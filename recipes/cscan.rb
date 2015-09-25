# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Recipe:: cscan
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

git "#{node['faraday']['install_dir']}/scripts/cscan" do
  repository node['faraday']['cscan']['git_repository']
  reference node['faraday']['cscan']['git_reference']
end

execute 'install-pip-packages' do
  command "pip install #{node['faraday']['cscan']['pip_packages'].join(' ')}"
  cwd node['faraday']['install_dir']
end

template "#{node['faraday']['install_dir']}/scripts/cscan/config.py" do
  source 'cscan/config.py.erb'
  variables config: node['faraday']['cscan']['config']
end
