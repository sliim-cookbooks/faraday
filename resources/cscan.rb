# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Resource:: cscan
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

actions :install, :configure

attribute :name, kind_of: String
attribute :path, kind_of: String, default: "#{node['faraday']['install_dir']}/scripts"
attribute :git_repository, kind_of: String, default: 'https://github.com/infobyte/cscan'
attribute :git_reference, kind_of: String, default: 'master'
attribute :ips, kind_of: Array, default: []
attribute :websites, kind_of: Array, default: []
attribute :config, kind_of: Hash, default: node['faraday']['cscan']['config']
attribute :cookbook, kind_of: String, default: 'faraday'
attribute :crond, kind_of: Hash, default: {}

def initialize(*args)
  super
  @action = :create
  @resource_name = :faraday_cscan
end
