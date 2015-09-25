# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::cscan' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['faraday']['install_dir'] = '/opt/faraday-dev'
      node.set['faraday']['cscan']['git_repository'] = 'git://remote/cscan.git'
      node.set['faraday']['cscan']['git_reference'] = 'dev'
      node.set['faraday']['cscan']['config']['nmap'] = 'custom-nmap'
      node.set['faraday']['cscan']['config']['nikto'] = 'custom-nikto'
    end.converge described_recipe
  end

  it 'syncs git[/opt/faraday-dev/scripts/cscan]' do
    expect(subject).to sync_git('/opt/faraday-dev/scripts/cscan')
      .with(repository: 'git://remote/cscan.git',
            reference: 'dev')
  end

  it 'runs execute[install-pip-package]' do
    expect(subject).to run_execute('install-pip-packages')
      .with(command: 'pip install python-owasp-zap-v2 w3af-api-client',
            cwd: '/opt/faraday-dev')
  end

  it 'creates template[/opt/faraday-dev/scripts/cscan/config.py]' do
    config_file = '/opt/faraday-dev/scripts/cscan/config.py'
    matches = [/'CS_NMAP' : "custom-nmap"/,
               /'CS_NIKTO' : "custom-nikto",/]

    expect(subject).to create_template(config_file)
      .with(source: 'cscan/config.py.erb')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end
end
