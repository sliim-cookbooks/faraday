# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/root/.faraday/config/config.xml' do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
