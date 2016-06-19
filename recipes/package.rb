# -*- coding: utf-8 -*-
#
# Cookbook Name:: faraday
# Recipe:: package
#
# Copyright 2015, Sliim
#

include_recipe 'faraday'

package 'python-faraday' do
  action :upgrade
end
