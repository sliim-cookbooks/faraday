# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/home/kitchen/.faraday/config/config.xml' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'kitchen' }
  it { should be_grouped_into 'kitchen' }
end
