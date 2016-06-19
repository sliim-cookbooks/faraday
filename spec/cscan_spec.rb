# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::cscan' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['faraday']['install_dir'] = '/opt/faraday-dev'
      node.set['faraday']['cscan']['ips'] = ['192.168.0.42']
      node.set['faraday']['cscan']['websites'] = ['http://192.168.0.42']
    end.converge described_recipe
  end

  it 'includes recipe[faraday::sources]' do
    expect(subject).to include_recipe('faraday::sources')
  end

  # FIXME: ArgumentError when trying to expect pip packages
  # %w(python-owasp-zap-v2 w3af-api-client).each do |pkg|
  #   it "installs python_package[#{pkg}]" do
  #     expect(subject).to install_python_package(pkg)
  #       .with(python: '/usr/bin/python',
  #             virtualenv: 'faraday-venv')
  #   end
  # end

  it 'configures faraday_cscan[default]' do
    expect(subject).to configure_faraday_cscan('default')
      .with(ips: ['192.168.0.42'],
            websites: ['http://192.168.0.42'])
  end
end
