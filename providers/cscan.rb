# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Provider:: cscan
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

action :install do
  git "#{node['faraday']['install_dir']}/scripts/cscan-#{new_resource.name}" do
    repository node['faraday']['cscan']['git_repository']
    reference node['faraday']['cscan']['git_reference']
  end

  new_resource.updated_by_last_action(true)
end

action :configure do
  cscan_dir = "cscan-#{new_resource.name}"
  cscan_dir = 'cscan' if new_resource.name == 'default'

  template "#{node['faraday']['install_dir']}/scripts/#{cscan_dir}/config.py" do
    source 'cscan/config.py.erb'
    variables config: new_resource.config
    cookbook new_resource.cookbook
  end

  template "#{node['faraday']['install_dir']}/scripts/#{cscan_dir}/ips.txt" do
    source 'cscan/targets.erb'
    variables targets: new_resource.ips
    cookbook new_resource.cookbook
  end

  template "#{node['faraday']['install_dir']}/scripts/#{cscan_dir}/websites.txt" do
    source 'cscan/targets.erb'
    variables targets: new_resource.websites
    cookbook new_resource.cookbook
  end

  new_resource.updated_by_last_action(true)
end
