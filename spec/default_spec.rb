# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'faraday::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new.converge described_recipe
  end

  ['git-core', 'libpq-dev'].each do |pkg|
    it "installs package[#{pkg}]" do
      expect(subject).to install_package(pkg)
    end
  end
end
