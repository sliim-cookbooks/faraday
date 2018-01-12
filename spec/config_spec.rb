# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'faraday::config' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['faraday_config'],
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['faraday']['user'] = 'faradev'
      node.override['faraday']['home'] = '/home/faraday'
      node.override['faraday']['config']['appname'] = 'Faraday - PTI'
      node.override['faraday']['config']['version'] = '13.37'
      node.override['faraday']['config_attrs']['appname'] = { foo: 'bar' }
    end.converge described_recipe
  end

  it 'creates faraday_config[/home/faraday/.faraday/config]' do
    expect(subject).to create_faraday_config('faradev')
      .with(home: '/home/faraday')
  end

  it 'creates directory[/home/faraday/.faraday/config]' do
    expect(subject).to create_directory('/home/faraday/.faraday/config')
      .with(owner: 'faradev',
            group: 'faradev',
            recursive: true)
  end

  it 'creates template[/home/faraday/.faraday/config/config.xml]' do
    config_file = '/home/faraday/.faraday/config/config.xml'
    matches = [/<!-- Generated by Chef! Do not edit/,
               %r{<appname foo="bar">Faraday - PTI</appname>},
               %r{<version>13.37</version>}]

    expect(subject).to create_template(config_file)
      .with(owner: 'faradev',
            group: 'faradev',
            source: 'config.xml.erb')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end
end
