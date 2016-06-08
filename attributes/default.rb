# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Attributes:: default
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

default['faraday']['packages'] = ['git-core', 'libpq-dev']
default['faraday']['git_repository'] = 'https://github.com/infobyte/faraday'
default['faraday']['git_reference'] = 'v1.0.20'
default['faraday']['install_dir'] = '/opt/faraday'
default['faraday']['python_runtime'] = '2'
