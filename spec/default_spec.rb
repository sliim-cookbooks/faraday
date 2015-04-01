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

  it 'should install required packages' do
    ['git-core', 'ipython', 'python-pip', 'python-dev'].each do |pkg|
      expect(subject).to install_package(pkg)
    end
  end

  it 'should clone git repository' do
    expect(subject).to sync_git('/opt/faraday-dev')
      .with(repository: 'git://remote/faraday.git',
            reference: 'dev')
  end

  it 'should install python packages' do
    expect(subject).to run_execute('install-pip-packages')
      .with(command: 'pip install couchdbkit mockito whoosh restkit flask',
            cwd: '/opt/faraday-dev')
  end
end
