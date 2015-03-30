# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Recipe:: config
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

directory "#{node['faraday']['user_home']}/.faraday/config" do
  owner node['faraday']['user']
  group node['faraday']['group']
  recursive true
end

template "#{node['faraday']['user_home']}/.faraday/config/config.xml" do
  owner node['faraday']['user']
  group node['faraday']['group']
  source 'config.xml.erb'
  variables config: node['faraday']['config'],
            attrs: node['faraday']['config_attrs']
end
