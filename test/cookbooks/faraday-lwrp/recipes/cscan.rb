# -*- coding: utf-8 -*-

faraday_cscan 'local' do
  action [:install, :configure]
  ips ['192.168.13.37', '192.168.13.38']
  websites ['https://192.168.13.42:443/']
end

faraday_cscan 'local2' do
  action [:install, :configure]
  path '/tmp'
  ips ['192.168.14.37', '192.168.14.38']
  websites ['https://192.168.14.42:443/']
  crond weekday: 5
end
