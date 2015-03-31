# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Attributes:: config
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

default['faraday']['user'] = 'root'
default['faraday']['group'] = 'root'
if node['faraday']['user'] == 'root'
  default['faraday']['home'] = '/root'
else
  default['faraday']['home'] = "/home/#{node['faraday']['user']}"
end

default['faraday']['config']['appname'] = 'Faraday - Penetration Test IDE'
default['faraday']['config']['version'] = '1.0'
default['faraday']['config']['debug_status'] = 0
default['faraday']['config']['font'] = '-Misc-Fixed-medium-r-normal-*-12-100-100-100-c-70-iso8859-1'
default['faraday']['config']['home_path'] = '~/'
default['faraday']['config']['image_path'] = '~/.faraday/images/'
default['faraday']['config']['icons_path'] = '~/.faraday/images/icons/'
default['faraday']['config']['data_path'] = '~/.faraday/data/'
default['faraday']['config']['config_path'] = '~/.faraday/'
default['faraday']['config']['default_temp_path'] = '~/.faraday/temp/'
default['faraday']['config']['persistence_path'] = '~/.faraday/persistence/'
default['faraday']['config']['report_path'] = '~/.faraday/report/'
default['faraday']['config']['hstactions_path'] = '~/.faraday/hstactions.dat'
default['faraday']['config']['default_category'] = 'General'
default['faraday']['config']['auto_share_workspace'] = 1
default['faraday']['config']['network_location'] = 'LAN'
default['faraday']['config']['perspective_view'] = 'Hosts'
default['faraday']['config']['log_console_toggle'] = ''
default['faraday']['config']['shell_maximized'] = 0
default['faraday']['config']['host_tree_toggle'] = ''
default['faraday']['config']['api_con_info'] = 'None'
default['faraday']['config']['api_con_info_host'] = 'None'
default['faraday']['config']['api_con_info_port'] = 'None'
default['faraday']['config']['auth'] = 0
default['faraday']['config']['repo_url'] = ''
default['faraday']['config']['repo_user'] = 'u'
default['faraday']['config']['repo_password'] = ''
default['faraday']['config']['couch_uri'] = ''
default['faraday']['config']['couch_is_replicated'] = ''
default['faraday']['config']['couch_replics'] = ''
default['faraday']['config']['updates_uri'] = 'https://www.faradaysec.com/scripts/updates.php'
default['faraday']['config']['tickets_uri'] = 'https://www.faradaysec.com/scripts/listener.php'
default['faraday']['config']['tickets_template'] = '{}'
default['faraday']['config']['tickets_api'] = '{}'

default['faraday']['config_attrs']['auth'] = { encrypted: 'no',
                                               algorithm: 'OTR' }
default['faraday']['config_attrs']['repo_url'] = { type: 'svn' }
