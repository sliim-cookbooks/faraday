# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::package' do
  let(:subject) do
    ChefSpec::SoloRunner.new.converge described_recipe
  end

  it 'upgrades package[python-faraday]' do
    expect(subject).to upgrade_package('python-faraday')
  end
end
