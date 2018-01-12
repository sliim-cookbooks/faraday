# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'faraday::python' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '9.0') do |node|
      node.override['faraday']['install_dir'] = '/opt/faradev'
      node.override['faraday']['python_runtime'] = '2'
    end.converge described_recipe
  end

  it 'installs python_runtime[2]' do
    expect(subject).to install_python_runtime('2')
  end

  it 'creates python_virtualenv[faraday-venv]' do
    expect(subject).to create_python_virtualenv('faraday-venv')
      .with(path: '/opt/faradev/.venv')
  end
end
