# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/opt/faraday-test/scripts/cscan' do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/opt/faraday-test/scripts/cscan/config.py' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/opt/faraday-test/scripts/cscan/ips.txt' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(/127.0.1.1/) }
end

describe file '/opt/faraday-test/scripts/cscan/websites.txt' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(%r{https://localhost:443}) }
end
