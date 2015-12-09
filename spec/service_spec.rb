# -*- coding: utf-8 -*-

require 'chefspec'

describe 'faraday::service' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['faraday']['install_dir'] = '/opt/faraday-dev'
      node.set['faraday']['service']['RUN'] = true
      node.set['faraday']['service']['DAEMON_ARGS'] = '--gui=no-gui -p 1337'
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

  it 'creates faraday_config[/opt/faraday-dev/.faraday/config]' do
    expect(subject).to create_faraday_config('faraday')
      .with(home: '/opt/faraday-dev')
  end

  it 'creates template[/opt/faraday-dev/server]' do
    expect(subject).to create_template('/opt/faraday-dev/server')
      .with(source: 'service/server.erb',
            owner: 'root',
            group: 'root',
            mode: '0755')
  end

  it 'creates template[/etc/default/faraday]' do
    expect(subject).to create_template('/etc/default/faraday')
      .with(source: 'service/default.erb',
            owner: 'root',
            group: 'root',
            mode: '0644')
    [/^DAEMON_ARGS="--gui=no-gui -p 1337"$/, /^RUN="true"$/].each do |m|
      expect(subject).to render_file('/etc/default/faraday').with_content(m)
    end
  end

  it 'creates template[/etc/init.d/faraday]' do
    expect(subject).to create_template('/etc/init.d/faraday')
      .with(source: 'service/init.erb',
            owner: 'root',
            group: 'root',
            mode: '0755')
  end

  it 'runs execute[chown -R faraday /opt/faraday-dev]' do
    expect(subject).to run_execute('chown -R faraday /opt/faraday-dev')
  end

  it 'enables service[faraday]' do
    expect(subject).to enable_service('faraday')
  end

  it 'starts service[faraday]' do
    expect(subject).to start_service('faraday')
  end
end
