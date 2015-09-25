# -*- coding: utf-8 -*-

name 'faraday'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache 2.0'
description 'Installs/Configures Faraday'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'faraday::default', 'Basic install of Faraday'
recipe 'faraday::config', 'Configure Faraday for a specific user'
recipe 'faraday::cscan', 'Install continuous scanning tool'

supports 'debian', '= 7.0'

source_url 'https://github.com/sliim-cookbooks/faraday' if
  respond_to?(:source_url)
issues_url 'https://github.com/sliim-cookbooks/faraday/issues' if
    respond_to?(:issues_url)
