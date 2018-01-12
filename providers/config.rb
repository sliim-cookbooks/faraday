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

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  config = Chef::Mixin::DeepMerge.merge(node['faraday']['config'],
                                        new_resource.config)
  attrs = Chef::Mixin::DeepMerge.merge(node['faraday']['config_attrs'],
                                       new_resource.config_attrs)

  user = new_resource.owner
  home = new_resource.home || (user == 'root' ? '/root' : "/home/#{user}")

  directory "#{home}/.faraday" do
    owner user
    group user
  end

  directory "#{home}/.faraday/config" do
    owner user
    group user
    recursive true
  end

  template "#{home}/.faraday/config/#{new_resource.file}" do
    owner user
    group user
    source 'config.xml.erb'
    cookbook new_resource.cookbook
    variables config: config,
              attrs: attrs
  end
end

action :delete do
  user = new_resource.owner
  home = new_resource.home || (user == 'root' ? '/root' : "/home/#{user}")

  file "#{home}/.faraday/config/#{new_resource.file}" do
    action :delete
  end
end
