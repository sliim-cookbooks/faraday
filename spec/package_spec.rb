# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'faraday::package' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '9.0').converge described_recipe
  end

  it 'includes recipe[faraday]' do
    expect(subject).to include_recipe('faraday')
  end

  it 'upgrades package[python-faraday]' do
    expect(subject).to upgrade_package('python-faraday')
  end
end
