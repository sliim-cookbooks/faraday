# -*- coding: utf-8 -*-

name 'faraday'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache 2.0'
description 'Installs/Configures Faraday'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.3'

recipe 'faraday::default', 'Faraday install with python venv'
recipe 'faraday::config', 'Configure Faraday for a specific user'
recipe 'faraday::service', 'Configure a Faraday server'
recipe 'faraday::cscan', 'Install continuous scanning tool'

depends 'poise-python'
depends 'cron'

supports 'debian', '> 7.0'

source_url 'https://github.com/sliim-cookbooks/faraday' if
  respond_to?(:source_url)
issues_url 'https://github.com/sliim-cookbooks/faraday/issues' if
    respond_to?(:issues_url)
