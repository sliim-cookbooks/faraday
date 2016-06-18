# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::gtk' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['faraday']['gtk_packages'] = ['python-gobject', 'zsh', 'curl']
    end.converge described_recipe
  end

  ['python-gobject', 'zsh', 'curl'].each do |pkg|
    it "installs package[#{pkg}]" do
      expect(subject).to install_package(pkg)
    end
  end
end
