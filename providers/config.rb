# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Provider:: config
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

action :create do
  config = Chef::Mixin::DeepMerge.merge(node['faraday']['config'],
                                        new_resource.config)
  attrs = Chef::Mixin::DeepMerge.merge(node['faraday']['config_attrs'],
                                       new_resource.config_attrs)

  directory new_resource.path do
    owner new_resource.user
    group new_resource.group
    recursive true
  end

  template "#{new_resource.path}/config.xml" do
    owner new_resource.user
    group new_resource.group
    source 'config.xml.erb'
    variables config: config,
              attrs: attrs
  end

  new_resource.updated_by_last_action(true)
end
