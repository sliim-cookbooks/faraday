faraday CHANGELOG
=================

This file is used to list changes made in each version of the faraday cookbook.

2.1.0
-----
- server/service improvements:
  - install pip requirement when installed from sources
  - activate virtualenv in init script when installed from sources
- Enabled system_site_packages in virtualenv

2.0.0
-----
- Default Faraday version: 2.0.0
- Remove Debian 7 as tested platform
- Add `faraday::server` recipe to configure Faraday server
- Update `faraday::service` to run faraday server as service daemon.
- Improve CScan configuration (Key: Value attributes)
- Permissions minor fixes

1.1.0
-----
- Provides multiple ways to install Faraday
- Add recipe to install GTK dependencies
- Set default Faraday version to 1.0.21
- New recipes: `faraday::gtk`, `faraday::package` and `faraday::sources`

1.0.3
-----
- Default faraday version: 1.0.20

1.0.2
-----
- Continuous scanning cronjob fix

1.0.1
-----
- Default faraday version: 1.0.16

1.0.0
-----
- New recipe `faraday::service`
- New LWRP: `faraday_config` to manage faraday configs
- New LWRP: `faraday_cscan` to manage cscan dirs
- New dependencies: `poise-python` (replace `python`) and `cron`

###### Potential breaking changes:
- Python is now managed with `poise-python` cookbook

0.2.1
-----
- Readme update for faraday::cscan

0.2.0
-----
- faraday::cscan: Installs Faraday continuous scanning tool

0.1.0
-----
- Initial release of faraday cookbook
