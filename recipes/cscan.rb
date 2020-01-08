# -*- coding: utf-8 -*-
#
# Cookbook:: faraday
# Recipe:: cscan
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

include_recipe 'faraday::sources'

node['faraday']['cscan']['pip_packages'].each do |pkg|
  python_package pkg do
    python node['faraday']['python_runtime']
    virtualenv 'faraday-venv'
  end
end

faraday_cscan 'default' do
  action :configure
  config node['faraday']['cscan']['config']
  ips node['faraday']['cscan']['ips']
  websites node['faraday']['cscan']['websites']
end
