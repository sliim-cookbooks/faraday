# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe file '/opt/faraday-test' do
  it { should be_directory }
  it { should be_mode 755 }
end
