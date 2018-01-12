# -*- coding: utf-8 -*-

name 'faraday'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache-2.0'
description 'Installs/Configures Faraday'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12.5' if respond_to?(:chef_version)
version '2.1.1'

recipe 'faraday::default', 'Install faraday packages dependencies'
recipe 'faraday::package', 'Install python-faraday package'
recipe 'faraday::sources', 'Install Faraday from sources with a virtualenv'
recipe 'faraday::gtk', 'Install required packages for GTK GUI'
recipe 'faraday::config', 'Configure Faraday for a specific user'
recipe 'faraday::service', 'Configure a Faraday server'
recipe 'faraday::cscan', 'Install continuous scanning tool'
recipe 'faraday::server', 'Setup faraday server configuration'

depends 'poise-python'
depends 'cron'

supports 'debian', '> 8.0'

source_url 'https://github.com/sliim-cookbooks/faraday' if
  respond_to?(:source_url)
issues_url 'https://github.com/sliim-cookbooks/faraday/issues' if
    respond_to?(:issues_url)
