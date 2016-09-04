# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::sources' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['faraday']['git_repository'] = 'git://remote/faraday.git'
      node.override['faraday']['git_reference'] = 'dev'
      node.override['faraday']['install_dir'] = '/opt/faradev'
    end.converge described_recipe
  end

  it 'includes recipe[faraday]' do
    expect(subject).to include_recipe('faraday')
  end

  it 'syncs git[/opt/faradev]' do
    expect(subject).to sync_git('/opt/faradev')
      .with(repository: 'git://remote/faraday.git',
            reference: 'dev')
  end

  it 'installs python_runtime[2]' do
    expect(subject).to install_python_runtime('2')
  end

  it 'creates python_virtualenv[faraday-venv]' do
    expect(subject).to create_python_virtualenv('faraday-venv')
      .with(path: '/opt/faradev/.venv')
  end

  # FIXME: ArgumentError when trying to expect pip requirements
  # it 'installs pip_requirements[/opt/faradev/requirements.txt]' do
  # expect(subject).to install_pip_requirements('/opt/faradev/requirements.txt')
  #     .with(python: '/usr/bin/python',
  #           virtualenv: 'faraday-venv')
  # end
end
