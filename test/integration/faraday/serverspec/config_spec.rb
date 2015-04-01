# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/home/vagrant/.faraday/config/config.xml' do
  it { should be_file }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
end
