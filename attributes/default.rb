# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Attributes:: default
#

default['faraday']['packages'] = ['git-core', 'libpq-dev']
default['faraday']['gtk_packages'] = ['gir1.2-gtk-3.0', 'gir1.2-vte-2.91',
                                      'python-pip', 'python-gobject', 'zsh', 'curl']
default['faraday']['git_repository'] = 'https://github.com/infobyte/faraday'
default['faraday']['git_reference'] = 'v1.0.21'
default['faraday']['install_dir'] = '/opt/faraday'
default['faraday']['python_runtime'] = '2'

# Configuration
default['faraday']['user'] = 'root'
if node['faraday']['user'] == 'root'
  default['faraday']['home'] = '/root'
else
  default['faraday']['home'] = "/home/#{node['faraday']['user']}"
end
default['faraday']['config'] = {
  appname: 'Faraday - Penetration Test IDE',
  version: '1.0.21',
  debug_status: 0,
  font: '-Misc-Fixed-medium-r-normal-*-12-100-100-100-c-70-iso8859-1',
  home_path: '~/',
  image_path: '~/.faraday/images/',
  icons_path: '~/.faraday/images/icons/',
  data_path: '~/.faraday/data/',
  config_path: '~/.faraday/',
  default_temp_path: '~/.faraday/temp/',
  persistence_path: '~/.faraday/persistence/',
  report_path: '~/.faraday/report/',
  hstactions_path: '~/.faraday/hstactions.dat',
  default_category: 'General',
  auto_share_workspace: 1,
  network_location: 'LAN',
  perspective_view: 'Hosts',
  log_console_toggle: '',
  shell_maximized: 0,
  host_tree_toggle: '',
  api_con_info: 'None',
  api_con_info_host: 'None',
  api_con_info_port: 'None',
  auth: 0,
  repo_url: '',
  repo_user: 'u',
  repo_password: '',
  couch_uri: '',
  couch_is_replicated: '',
  couch_replics: '',
  updates_uri: 'https://www.faradaysec.com/scripts/updates.php',
  tickets_uri: 'https://www.faradaysec.com/scripts/listener.php',
  tickets_template: '{}',
  tickets_api: '{}'
}
default['faraday']['config_attrs'] = {
  repo_url: {
    type: 'svn'
  },
  auth: {
    encrypted: 'no',
    algorithm: 'OTR'
  }
}

# Continuous scanning
default['faraday']['cscan']['pip_packages'] = %w(python-owasp-zap-v2 w3af-api-client)
default['faraday']['cscan']['ips'] = ['127.0.0.1']
default['faraday']['cscan']['websites'] = ['http://127.0.0.1:80']
default['faraday']['cscan']['config'] = {
  CS_NMAP: 'nmap',
  CS_OPENVAS_USER: 'admin',
  CS_OPENVAS_PASSWORD: 'openvas',
  CS_OPENVAS_SCAN_CONFIG: 'Full and fast',
  CS_OPENVAS_ALIVE_TEST: 'ICMP, TCP-ACK Service &amp; ARP Ping',
  CS_OPENVAS: 'omp',
  CS_BURP: '/root/tools/burpsuite_pro_v1.6.26.jar',
  CS_NIKTO: 'nikto',
  CS_W3AF: '/root/tools/w3af/w3af_api',
  CS_PROFILE: '/root/tools/w3af/profiles/fast_scan.pw3af',
  CS_ZAP: '/root/tools/zap/ZAP_D-2015-08-24/zap.sh',
  CS_NESSUS_URL: 'https://127.0.0.1:8834',
  CS_NESSUS_USER: 'nessus',
  CS_NESSUS_PASS: 'nessus',
  CS_NESSUS_PROFILE: 'Basic Network Scan'
}

# Service
default['faraday']['service'] = {
  RUN: true,
  NAME: 'faraday-server',
  USER: 'faraday',
  INSTALL_DIR: node['faraday']['install_dir']
}
