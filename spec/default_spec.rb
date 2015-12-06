# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['faraday']['git_repository'] = 'git://remote/faraday.git'
      node.set['faraday']['git_reference'] = 'dev'
      node.set['faraday']['install_dir'] = '/opt/faraday-dev'
    end.converge described_recipe
  end

  it 'installs package[git-core]' do
    expect(subject).to install_package('git-core')
  end

  it 'syncs git[/opt/faraday-dev]' do
    expect(subject).to sync_git('/opt/faraday-dev')
      .with(repository: 'git://remote/faraday.git',
            reference: 'dev')
  end

  it 'installs python_runtime[2]' do
    expect(subject).to install_python_runtime('2')
  end

  it 'creates python_virtualenv[faraday-venv]' do
    expect(subject).to create_python_virtualenv('faraday-venv')
      .with(python: '/usr/bin/python',
            path: '/opt/faraday-dev/.venv')
  end

  # FIXME: ArgumentError when trying to expect pip requirements
  # it 'installs pip_requirements[/opt/faraday-dev/requirements.txt]' do
  #   expect(subject).to install_pip_requirements(
  #                        '/opt/faraday-dev/requirements.txt')
  #     .with(python: '/usr/bin/python',
  #           virtualenv: 'faraday-venv')
  # end
end
