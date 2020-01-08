# -*- coding: utf-8 -*-

require_relative 'spec_helper'

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

  it 'includes recipe[faraday::python]' do
    expect(subject).to include_recipe('faraday::python')
  end

  # FIXME: ArgumentError when trying to expect pip requirements
  # it 'installs pip_requirements[/opt/faradev/requirements.txt]' do
  # expect(subject).to install_pip_requirements('/opt/faradev/requirements.txt')
  #     .with(python: '/usr/bin/python',
  #           virtualenv: 'faraday-venv')
  # end
end
