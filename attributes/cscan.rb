# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Attributes:: cscan
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

default['faraday']['cscan']['git_repository'] = 'https://github.com/infobyte/cscan'
default['faraday']['cscan']['git_reference'] = 'master'
default['faraday']['cscan']['pip_packages'] = %w(python-owasp-zap-v2 w3af-api-client)

default['faraday']['cscan']['config'] = {
  nmap: 'nmap',
  openvas: {
    user: 'admin',
    password: 'openvas',
    scan_config: 'Full and fast',
    alive_test: 'ICMP, TCP-ACK Service &amp; ARP Ping',
    openvas: 'omp'
  },
  burp: '/root/tools/burpsuite_pro_v1.6.26.jar',
  nikto: 'nikto',
  w3af: '/root/tools/w3af/w3af_api',
  w3af_profile: '/root/tools/w3af/profiles/fast_scan.pw3af',
  zap: '/root/tools/zap/ZAP_D-2015-08-24/zap.sh',
  nessus: {
    url: 'https://127.0.0.1:8834',
    user: 'nessus',
    pass: 'nessus',
    profile: 'Basic Network Scan'
  }
}
