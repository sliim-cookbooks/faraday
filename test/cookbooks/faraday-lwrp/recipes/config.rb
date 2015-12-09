# -*- coding: utf-8 -*-

faraday_config 'root' do
  config couch_uri: 'https://couchdb-host:6984',
         last_workspace: 'faraday-workspace'
  config_attrs last_workspace: { env: 'kitchen' }
end

faraday_config 'kitchen' do
  file 'user.xml'
  config last_workspace: 'kitchen-workspace'
end

faraday_config 'kitchen-test-create' do
  owner 'kitchen'
  file 'test.xml'
end
faraday_config 'kitchen-test-delete' do
  action :delete
  owner 'kitchen'
  file 'test.xml'
end
