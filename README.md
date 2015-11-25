faraday Cookbook
================
Installs and configure Faraday - A collaborative penetration testing tool -
https://www.faradaysec.com
[![Cookbook Version](https://img.shields.io/cookbook/v/faraday.svg)](https://community.opscode.com/cookbooks/faraday) [![Build Status](https://travis-ci.org/sliim-cookbooks/faraday.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/faraday) 

Requirements
------------
#### Services
- `couchdb`

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 7`
- `Debian 8`

Attributes
----------
#### faraday::default

|  Key                        |  Type   |  Description                                                        |
| --------------------------- | ------- | ------------------------------------------------------------------- |
| `[faraday][packages]`       | Array   | Package list to install (default: [git-core, libpq-dev])            |
| `[faraday][git_repository]` | String  | Faraday repository (default: https://github.com/infobyte/faraday)   |
| `[faraday][git_reference]`  | String  | Faraday reference or version (default: master)                      |
| `[faraday][install_dir]`    | String  | Faraday install directory (default: /opt/faraday)                   |
| `[faraday][python_runtime]` | String  | Python runtime to use, use for `poise-python` cookbook (default: 2) |

#### faraday::config

|  Key               |  Type  |  Description                                           |
| ------------------ | ------ | ------------------------------------------------------ |
| `[faraday][user]`  | String | User to set configuration, must exists (default: root) |
| `[faraday][group]` | String | Group for file permission, must exists (default: root) |
| `[faraday][home]`  | String | User's home directory (default: /root)                 |

All others attributes in `['faraday']['config']` namespace will generate dynamically the
configuration file as XML format in `$HOME/.faraday/config/config.xml`.

Use the `['faraday']['config_attrs']` namespace to set xml attributes. See `attributes/config.rb` for more details.

#### faraday::service

|  Key                 |  Type  |  Description                                          |
| -------------------- | ------ | ----------------------------------------------------- |
| `[faraday][service]` |  Hash  | Hash of variables to override for service init script |

#### faraday::cscan
<table>
<tr>
<th>Key</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
<tr>
<td><tt>['faraday']['cscan']['git_repository']</tt></td>
<td>String</td>
<td>cscan repository.</td>
<td><tt>https://github.com/infobyte/cscan</tt></td>
</tr>
<tr>
<td><tt>['faraday']['cscan']['git_reference']</tt></td>
<td>String</td>
<td>Reference of the repository to sync.</td>
<td><tt>master</tt></td>
</tr>
<tr>
<td><tt>['faraday']['cscan']['pip_packages']</tt></td>
<td>Array</td>
<td>Python package to install</td>
<td><tt>[python-owasp-zap-v2, w3af-api-client]</tt></td>
</tr>
<tr>
<td><tt>['faraday']['cscan']['config']</tt></td>
<td>Hash</td>
<td>Configure cscan with some values, this set CSCAN_DIR/config.py</td>
<td><tt>See atrribute file.</tt></td>
</tr>
</table>

Usage
-----
#### faraday::default
Include `faraday` in your node's `run_list` to install faraday and its requirements:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]"
  ]
}
```

#### faraday::config
Include `faraday::config` in your node's `run_list` to configure faraday for a user:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday::config]"
  ],
  "attributes": {
    "faraday": {
      "user": "my_user",
      "config": {
        ... configuration here ...
      }
    }
  }
}
```

#### faraday::service
Include `faraday::service` in your node's `run_list` to configure faraday as a server:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]",
    "recipe[faraday::service]"
  ],
  "attributes": {
    "faraday": {
      "service": {
        "DAEMON_ARGS": "--gui=no-gui --port 31337"
      }
    }
  }
}
```

#### faraday::cscan
Include `faraday::cscan` in your node's `run_list` to install continuous scanning:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday::cscan]"
  ],
  "attributes": {
    "faraday": {
      "cscan": {
        "config": {
          ... configuration here ...
        }
      }
    }
  }
}
```

#### Tests

- First, install dependencies:  
`bundle install`

- Run Checkstyle and ChefSpec:  
`bundle exec rake`

- Run Kitchen tests:  
`bundle exec rake kitchen`  

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
