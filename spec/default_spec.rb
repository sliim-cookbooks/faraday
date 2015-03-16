# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::default' do
  context 'on debian' do
    let(:subject) do
      ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache',
                               platform: 'debian',
                               version: '7.7') do |node|
        node.set['faraday']['git_repository'] = 'git://remote/faraday.git'
        node.set['faraday']['git_reference'] = 'dev'
        node.set['faraday']['install_dir'] = '/opt/faraday-dev'
      end.converge described_recipe
    end

    it 'should include apt recipe' do
      expect(subject).to include_recipe('apt')
    end

    it 'should install some packages' do
      ['python-pip', 'python-dev', 'python-qt4', 'ipython',
       'libc6-dev', 'libpq-dev', 'couchdb', 'git-core'].each do |p|
        expect(subject).to install_package(p)
      end
    end

    it 'should clone git repository' do
      expect(subject).to sync_git('/opt/faraday-dev')
        .with(repository: 'git://remote/faraday.git',
              reference: 'dev')
    end

    it 'should install python requirements' do
      expect(subject).to run_execute('install-pip-requirements')
        .with(command: 'pip install -r requirements.txt',
              cwd: '/opt/faraday-dev')
    end
  end
end
