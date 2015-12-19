faraday CHANGELOG
=================

This file is used to list changes made in each version of the faraday cookbook.

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
