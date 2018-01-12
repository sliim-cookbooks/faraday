# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'faraday::gtk' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '9.0') do |node|
      node.override['faraday']['gtk_packages'] = ['python-gobject', 'zsh', 'curl']
    end.converge described_recipe
  end

  ['python-gobject', 'zsh', 'curl'].each do |pkg|
    it "installs package[#{pkg}]" do
      expect(subject).to install_package(pkg)
    end
  end
end
