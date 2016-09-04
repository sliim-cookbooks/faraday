# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::server' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['faraday_config']) do |node|
      node.set['faraday']['install_dir'] = '/opt/faradev'
      node.set['faraday']['user'] = 'faradev'
      node.set['faraday']['home'] = '/home/faraday'
      node.set['faraday']['server']['config']['couchdb']['host'] = '10.37.13.42'
    end.converge described_recipe
  end

  it 'creates template[/opt/faradev/server/www/config/config.json]' do
    config_file = '/opt/faradev/server/www/config/config.json'

    expect(subject).to create_template(config_file)
      .with(owner: 'faradev',
            group: 'faradev',
            source: 'server/config.json.erb')

    expect(subject).to render_file(config_file)
      .with_content(/{"lic_db":"faraday_license","ver":""}/)
  end

  it 'creates directory[/home/faraday/.faraday/config]' do
    expect(subject).to create_directory('/home/faraday/.faraday/config')
      .with(owner: 'faradev',
            group: 'faradev',
            recursive: true)
  end

  it 'creates template[/home/faraday/.faraday/config/server.ini]' do
    config_file = '/home/faraday/.faraday/config/server.ini'
    matches = [/^\[faraday_server\]$/,
               /^port=5985$/,
               /^bind_address=localhost$/,
               /^\[ssl\]$/,
               /^port=6985$/,
               /^certificate=$/,
               /^keyfile=$/,
               /^\[couchdb\]$/,
               /^host=10.37.13.42$/,
               /^port=5984$/,
               /^ssl_port=6984$/,
               /^user=$/,
               /^password=$/,
               /^protocol=http$/]

    expect(subject).to create_template(config_file)
      .with(owner: 'faradev',
            group: 'faradev',
            source: 'server/config.ini.erb')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end
end
