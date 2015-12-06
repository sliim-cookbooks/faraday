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
  git "#{new_resource.path}/cscan-#{new_resource.name}" do
    repository new_resource.git_repository
    reference new_resource.git_reference
  end

  new_resource.updated_by_last_action(true)
end

action :configure do
  dirname = "cscan-#{new_resource.name}"
  dirname = 'cscan' if new_resource.name == 'default'

  template "#{new_resource.path}/#{dirname}/config.py" do
    source 'cscan/config.py.erb'
    variables config: new_resource.config
    cookbook new_resource.cookbook
  end

  template "#{new_resource.path}/#{dirname}/ips.txt" do
    source 'cscan/targets.erb'
    variables targets: new_resource.ips
    cookbook new_resource.cookbook
  end

  template "#{new_resource.path}/#{dirname}/websites.txt" do
    source 'cscan/targets.erb'
    variables targets: new_resource.websites
    cookbook new_resource.cookbook
  end

  unless new_resource.crond.empty?
    include_recipe 'cron'
    crond = new_resource.crond
    cron_d dirname do
      action :create
      hour crond[:hour] || '1'
      minute crond[:minute] || '*'
      weekday crond[:weekday] || '*'
      day crond[:day] || '*'
      month crond[:month] || '*'
      user crond[:user] || 'root'
      mailto crond[:mailto] if crond[:mailto]
      command crond[:command] || './cscan.py'
      path "#{new_resource.path}/#{dirname}"
    end
  end

  new_resource.updated_by_last_action(true)
end
