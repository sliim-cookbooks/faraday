# -*- coding: utf-8 -*-

name 'faraday'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache-2.0'
description 'Installs/Configures Faraday'
chef_version '>= 13'
version '2.1.1'

depends 'poise-python'
depends 'cron'
depends 'couchdb'

supports 'debian', '> 8.0'

source_url 'https://github.com/sliim-cookbooks/faraday'
issues_url 'https://github.com/sliim-cookbooks/faraday/issues'
