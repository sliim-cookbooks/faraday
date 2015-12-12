# -*- coding: utf-8 -*-

require 'chefspec'

describe 'faraday::service' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['faraday']['install_dir'] = '/opt/faraday-dev'
      node.set['faraday']['service']['RUN'] = true
      node.set['faraday']['service']['NAME'] = 'faraday-test'
      node.set['faraday']['service']['DAEMON_ARGS'] =
        'faraday.py --gui=no-gui -p 1337'
    end.converge(described_recipe)
  end

  it 'includes recipe[faraday]' do
    expect(subject).to include_recipe('faraday')
  end

  it 'creates user[faraday]' do
    expect(subject).to create_user('faraday')
      .with(home: '/opt/faraday-dev',
            system: true)
  end

  it 'creates group[faraday]' do
    expect(subject).to create_group('faraday')
      .with(members: ['faraday'])
  end

  it 'creates faraday_config[faraday]' do
    expect(subject).to create_faraday_config('faraday')
      .with(home: '/opt/faraday-dev', file: 'config.xml')
  end

  it 'creates template[/etc/default/faraday-test]' do
    expect(subject).to create_template('/etc/default/faraday-test')
      .with(source: 'service/default.erb',
            owner: 'root',
            group: 'root',
            mode: '0644')
    [/^DAEMON_ARGS="faraday.py --gui=no-gui -p 1337"$/,
     /^RUN="true"$/,
     /^NAME="faraday-test"/].each do |m|
      expect(subject).to render_file('/etc/default/faraday-test')
        .with_content(m)
    end
  end

  it 'creates template[/etc/init.d/faraday-test]' do
    expect(subject).to create_template('/etc/init.d/faraday-test')
      .with(source: 'service/init.erb',
            owner: 'root',
            group: 'root',
            mode: '0755')
  end

  it 'runs execute[chown -R faraday:faraday /opt/faraday-dev]' do
    expect(subject).to run_execute('chown -R faraday:faraday /opt/faraday-dev')
  end

  it 'enables service[faraday-test]' do
    expect(subject).to enable_service('faraday-test')
  end

  it 'starts service[faraday-test]' do
    expect(subject).to start_service('faraday-test')
  end
end
