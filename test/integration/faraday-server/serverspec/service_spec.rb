# -*- coding: utf-8 -*-
require 'serverspec'
set :backend, :exec

describe service 'faraday' do
  it { should be_running }
end
