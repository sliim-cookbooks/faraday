# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/opt/faraday-test/scripts/cscan-local' do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/opt/faraday-test/scripts/cscan-local/config.py' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/opt/faraday-test/scripts/cscan-local/ips.txt' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(/192.168.13.37/) }
  its(:content) { should match(/192.168.13.38/) }
end

describe file '/opt/faraday-test/scripts/cscan-local/websites.txt' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(%r{https://192.168.13.42:443}) }
end

describe file '/tmp/cscan-local2' do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/tmp/cscan-local2/config.py' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/tmp/cscan-local2/ips.txt' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(/192.168.14.37/) }
  its(:content) { should match(/192.168.14.38/) }
end

describe file '/tmp/cscan-local2/websites.txt' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(%r{https://192.168.14.42:443}) }
end

describe file '/etc/cron.d/cscan-local2' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
