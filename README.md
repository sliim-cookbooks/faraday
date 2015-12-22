faraday Cookbook
================
Installs and configures [Faraday](https://www.faradaysec.com) - A collaborative penetration testing tool!

[![Cookbook Version](https://img.shields.io/cookbook/v/faraday.svg)](https://community.opscode.com/cookbooks/faraday) [![Build Status](https://travis-ci.org/sliim-cookbooks/faraday.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/faraday) 

Requirements
------------
#### Cookbooks
- `poise-python` - https://supermarket.chef.io/cookbooks/poise-python
- `cron` - https://supermarket.chef.io/cookbooks/cron

#### Services
- `couchdb`

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 7`
- `Debian 8`

Attributes
----------
#### faraday::default

|  Key                        |  Type   |  Description                                                           |
| --------------------------- | ------- | ---------------------------------------------------------------------- |
| `[faraday][packages]`       | Array   | Package list to install (default: `[git-core, libpq-dev]`)             |
| `[faraday][git_repository]` | String  | Faraday repository (default: `https://github.com/infobyte/faraday`)    |
| `[faraday][git_reference]`  | String  | Faraday reference or version (default: `v1.0.16`)                      |
| `[faraday][install_dir]`    | String  | Faraday install directory (default: `/opt/faraday`)                    |
| `[faraday][python_runtime]` | String  | Python runtime to use, used for `poise-python` cookbook (default: `2`) |

#### faraday::config

|  Key               |  Type  |  Description                                     |
| ------------------ | ------ | ------------------------------------------------ |
| `[faraday][user]`  | String | User to configure, must exists (default: `root`) |
| `[faraday][home]`  | String | User's home directory (default: `/root`)         |

All others attributes in `['faraday']['config']` namespace will generate dynamically the
configuration file as XML format in `$HOME/.faraday/config/config.xml`.

Use the `['faraday']['config_attrs']` namespace to set xml attributes. See `attributes/config.rb` for more details.

#### faraday::service

|  Key                 |  Type  |  Description                                          |
| -------------------- | ------ | ----------------------------------------------------- |
| `[faraday][service]` |  Hash  | Hash of variables to override for service init script |

#### faraday::cscan
|  Key                             |  Type  |  Description                                                                  |
| -------------------------------- | ------ | ----------------------------------------------------------------------------- |
| `[faraday][cscan][pip_packages]` | Array  | Python packages to install (default: `[python-owasp-zap-v2 w3af-api-client]`) |
| `[faraday][cscan][config]`       | Hash   | Configuration for default cscan (default: `node[faraday][config]`)            |
| `[faraday][cscan][ips]`          | Array  | List of IPs for default cscan (default: `[127.0.0.1]`)                        |
| `[faraday][cscan][websites]`     | Array  | List of websites for default cscan (default: `[http://127.0.0.1:80]`)         |

Usage
-----
#### faraday::default
Include `faraday` in your node's `run_list` to install faraday and its requirements:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]"
  ],
  "attributes": {
    "faraday": {
      "git_reference": "v1.0.16",
      "install_dir": "/opt/faraday-1.0.16"
    }
  }
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
        "couch_uri": "http://127.0.0.1:5984",
        "last_workspace": "my_workspace"
      }
    }
  }
}
```

#### faraday::service
Include `faraday::service` in your node's `run_list` to configure faraday as a server (*Experimental*):

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]",
    "recipe[faraday::service]"
  ],
  "attributes": {
    "faraday": {
      "git_reference": "v1.0.16",
      "install_dir": "/opt/faraday",
      "python_runtime": "2",
      "service": {
        "RUN": "true",
        "NAME": "faraday-server",
        "USER": "faraday",
        "INSTALL_DIR": "/opt/faraday",
        "DAEMON_ARGS": "faraday.py --gui=no-gui --port 31337"
      },
      "config": {
        "version": "1.0.16",
        "couch_uri": "http://127.0.0.1:5984"
      }
    }
  }
}
```

#### faraday::cscan
Include `faraday::cscan` in your node's `run_list` to configure default continuous scanning:

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
          "couch_uri": "https://couchdb-host:6984",
          "last_workspace": "cscan_workspace"
        },
        "ips": ["192.168.0.1"],
        "websites": ["http://192.168.0.1"]
      }
    }
  }
}
```

#### Custom resources

##### faraday_config
This LWRP can be used to deploy many faraday configuration.

###### Actions
|  Action   |  Description                             |
| --------- | ---------------------------------------- |
| `:create` | Create configuration for a specific user |
| `:delete` | Delete user's configuration file         |

###### Attributes
|  Attribute     |  Type  |  Description                                                                           |
| -------------- | ------ | -------------------------------------------------------------------------------------- |
| `owner`        | String | Owner config file, this is the name attribute of this resource                         |
| `home`         | String | Home directory, if nil: provider will determine it depending of owner (default: `nil`) |
| `file`         | String | Configuration file name (default: `config.xml`)                                        |
| `cookbook`     | String | Optional cookbook name for template resource (default: `faraday`)                      |
| `config`       | Hash   | Configuration to deploy (default: `{}`)                                                |
| `config_attrs` | Hash   | Config attributes (default: `{}`)                                                      |

###### Example
```ruby
faraday_config 'sliim' do
  config last_workspace: 'sliim-corp'
  end

faraday_config 'sliim' do
  action :delete
  file 'user.xml'
end
```

##### faraday_cscan
Install and configure a continuous scanning directory.

###### Actions
|  Action       |  Description                                |
| ----------    | ------------------------------------------- |
| `:install`    | Install a new continuous scanning directory |
| `:configure`  | Configure a continuous scanning install     |

###### Attributes
|  Attribute       |  Type  |  Description                                                                           |
| ---------------- | ------ | -------------------------------------------------------------------------------------- |
| `name`           | String | Continuous scanning name (final dirname will be prepended with `cscan-`)               |
| `path`           | String | Optional path where will be created cscan dir (default: `FARADAY_INSTALL_DIR/scripts`) |
| `git_repository` | String | cscan repository (default: `https://github.com/infobyte/cscan`)                        |
| `git_reference`  | String | cscan reference (default: `master`)                                                    |
| `ips`            | Array  | List of IPs to configure (default: `[]`)                                               |
| `websites`       | Array  | List of websites to configure (default: `[]`)                                          |
| `config`         | Hash   | Config attributes (default: `node[faraday][cscan][config]`)                            |
| `cookbook`       | String | Optional cookbook name for templates (default: `faraday`)                              |
| `crond`          | Hash   | Cron setup. These attributes will be used for `cron_d` resource (default: `{}`)        |

###### Example
```ruby
faraday_cscan 'local' do
  action [:install, :configure]
  ips ['10.0.1.2',
       '10.0.1.3',
       '10.0.1.4']
  crond hour: 13,
        minute: 37,
        weekday: 5,
        user: 'faraday',
        mailto: 'you@gmail.com',
        command: ./cscan.py -p nmap.sh >> cron.log 2>&1 && mv output/* /opt/faraday/.faraday/report/cscan-local

end
```

Tests
-----

- First, install dependencies:  
`bundle install`

- Run Checkstyle and ChefSpec:  
`bundle exec rake`

- Run Kitchen tests:
`bundle exec rake kitchen`

If you have Docker, you can use the kitchen driver which is faster:
`export KITCHEN_YAML=.kitchen.docker.yml`  
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
