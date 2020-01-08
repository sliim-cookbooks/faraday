# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'faraday::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '9.0').converge described_recipe
  end

  %w(git libpq-dev).each do |pkg|
    it "installs package[#{pkg}]" do
      expect(subject).to install_package(pkg)
    end
  end
end
