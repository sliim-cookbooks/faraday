# -*- coding: utf-8 -*-
require 'serverspec'
set :backend, :exec

describe user 'faraday' do
  it { should exist }
  it { should have_home_directory '/opt/faraday-test' }
end

describe file '/opt/faraday-test' do
  it { should be_directory }
  it { should be_owned_by 'faraday' }
  it { should be_grouped_into 'faraday' }
end

describe file '/opt/faraday-test/.faraday/config/config.xml' do
  it { should be_file }
end

describe file '/etc/default/faraday-server' do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file '/etc/init.d/faraday-server' do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end
