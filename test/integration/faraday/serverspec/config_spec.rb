# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/home/kitchen/.faraday/config/config.xml' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'kitchen' }
  it { should be_grouped_into 'kitchen' }
end

describe file '/root/.faraday/config/config.xml' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(%r{<couch_uri>https://couchdb-host:6984</couch_uri>}) }
  its(:content) { should match(%r{<last_workspace env="kitchen">faraday-workspace</last_workspace>}) }
end

describe file '/home/kitchen/.faraday/config/user.xml' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'kitchen' }
  it { should be_grouped_into 'kitchen' }
  its(:content) { should match(%r{<last_workspace>kitchen-workspace</last_workspace>}) }
end

describe file '/home/kitchen/.faraday/config/test.xml' do
  it { should_not be_file }
end
