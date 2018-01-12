faraday Cookbook
================
Installs and configures [Faraday](https://www.faradaysec.com) - A collaborative penetration testing tool!

[![Cookbook Version](https://img.shields.io/cookbook/v/faraday.svg)](https://community.opscode.com/cookbooks/faraday) [![Build Status](https://travis-ci.org/sliim-cookbooks/faraday.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/faraday) 

Requirements
------------
#### Cookbooks
- `poise-python` - https://supermarket.chef.io/cookbooks/poise-python
- `couchdb` - https://supermarket.chef.io/cookbooks/couchdb
- `cron` - https://supermarket.chef.io/cookbooks/cron

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 8`

Attributes
----------
#### faraday::default

|  Key                             |  Type  |  Description                                                                                                |
| -------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------- |
| `[faraday][packages]`            | Array  | Package list to install (default: `[git-core, libpq-dev]`)                                                  |
| `[faraday][gtk_packages]`        | Array  | Python packages to install (default: `[gir1.2-gtk-3.0 gir1.2-vte-2.91 python-pip python-gobject zsh curl]`) |
| `[faraday][git_repository]`      | String | Faraday repository (default: `https://github.com/infobyte/faraday`)                                         |
| `[faraday][git_reference]`       | String | Faraday reference or version (default: `v2.0.0`)                                                            |
| `[faraday][install_dir]`         | String | Faraday install directory (default: `/opt/faraday`)                                                         |
| `[faraday][python_runtime]`      | String | Python runtime to use, used for `poise-python` cookbook (default: `2`)                                      |
| `[faraday][user]`                | String | User to configure, must exists (default: `root`)                                                            |
| `[faraday][home]`                | String | User's home directory (default: `/root`)                                                                    |
| `[faraday][config]`              | Hash   | Hash of faraday configuration (See attributes file for defaults)                                            |
| `[faraday][config_attrs]`        | Hash   | XML attributes for faraday configuration (See attributes file for defaults)                                 |
| `[faraday][cscan][pip_packages]` | Array  | Python packages to install (default: `[python-owasp-zap-v2 w3af-api-client]`)                               |
| `[faraday][cscan][config]`       | Hash   | Configuration for default cscan (see attributes file for defaults)                                          |
| `[faraday][cscan][ips]`          | Array  | List of IPs for default cscan (default: `[127.0.0.1]`)                                                      |
| `[faraday][cscan][websites]`     | Array  | List of websites for default cscan (default: `[http://127.0.0.1:80]`)                                       |
| `[faraday][service]`             | Hash   | Hash of variables to override for service init script                                                       |
| `[faraday][server][www]`         | Hash   | Faraday server www setup                                                                                    |
| `[faraday][server][config]`      | Hash   | Faraday server configuration hash                                                                           |



All others attributes in `['faraday']['config']` namespace will generate dynamically the
configuration file as XML format in `$HOME/.faraday/config/config.xml`.

Use the `['faraday']['config_attrs']` namespace to set xml attributes. See [default attributes](attributes/default.rb) for more details.

Usage
-----

### Installation
You have two ways to install Faraday: 

#### faraday::package
Use `faraday::package` to only install `python-faraday` package:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday::package]"
  ]
}
```

#### faraday::sources
Include `faraday::sources` in your node's `run_list` to install faraday and its requirements from source:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday::sources]"
  ],
  "attributes": {
    "faraday": {
      "git_reference": "v2.0.0",
      "install_dir": "/opt/faraday-2.0.0"
    }
  }
}
```

The `faraday::default` recipe will only install package dependencies. It is included in `faraday::package` and `faraday::sources`.

#### faraday::gtk
If you want to use the GTK GUI, you can include `faraday::gtk` to install extra dependencies.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]",
    "recipe[faraday::gtk]"
  ]
}
```

### Configuration

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
      "config": {
        "couch_uri": "https://couchdb-host:6984",
        "last_workspace": "cscan_workspace"
      },
      "cscan": {
        "config": {
          "CS_NMAP": "sudo nmap"
        },
        "ips": ["192.168.0.1"],
        "websites": ["http://192.168.0.1"]
      }
    }
  }
}
```

#### faraday::server
Include `faraday::server` in your node's `run_list` to configure Faraday Server:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]",
    "recipe[faraday::server]"
  ],
  "attributes": {
    "faraday": {
      "git_reference": "v2.0.0",
      "install_dir": "/opt/faraday",
      "python_runtime": "2",
      "config": {
        "version": "2.0.0",
        "couch_uri": "http://127.0.0.1:5985"
      },
      "server": {
        "config": {
          "couchdb": {
            "host": "couchdb.host"
          }
        }
      }
    }
  }
}
```

#### faraday::service
Include `faraday::service` to setup service for your Faraday server:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[faraday]",
    "recipe[faraday::server]",
    "recipe[faraday::service]"
  ],
  "attributes": {
    "faraday": {
      "git_reference": "v2.0.0",
      "install_dir": "/opt/faraday",
      "python_runtime": "2",
      "config": {
        "version": "2.0.0",
        "couch_uri": "http://127.0.0.1:5985"
      },
      "service": {
        "RUN": "true",
        "NAME": "faraday-server",
        "USER": "faraday",
        "INSTALL_DIR": "/opt/faraday",
        "DAEMON": "faraday-server.py",
        "DAEMON_ARGS": "--debug"
      }
    }
  }
}
```

### Custom resources

#### faraday_config
This LWRP can be used to deploy many faraday configuration.

##### Actions
|  Action   |  Description                             |
| --------- | ---------------------------------------- |
| `:create` | Create configuration for a specific user |
| `:delete` | Delete user's configuration file         |

##### Attributes
|  Attribute     |  Type  |  Description                                                                           |
| -------------- | ------ | -------------------------------------------------------------------------------------- |
| `owner`        | String | Owner config file, this is the name attribute of this resource                         |
| `home`         | String | Home directory, if nil: provider will determine it depending of owner (default: `nil`) |
| `file`         | String | Configuration file name (default: `config.xml`)                                        |
| `cookbook`     | String | Optional cookbook name for template resource (default: `faraday`)                      |
| `config`       | Hash   | Configuration to deploy (default: `{}`)                                                |
| `config_attrs` | Hash   | Config attributes (default: `{}`)                                                      |

##### Example
```ruby
faraday_config 'sliim' do
  config last_workspace: 'sliim-corp'
  end

faraday_config 'sliim' do
  action :delete
  file 'user.xml'
end
```

#### faraday_cscan
Install and configure a continuous scanning directory.

##### Actions
|  Action       |  Description                                |
| ----------    | ------------------------------------------- |
| `:install`    | Install a new continuous scanning directory |
| `:configure`  | Configure a continuous scanning install     |

##### Attributes
|  Attribute       |  Type  |  Description                                                                           |
| ---------------- | ------ | -------------------------------------------------------------------------------------- |
| `name`           | String | Continuous scanning name (final dirname will be prepended with `cscan-`)               |
| `user`           | String | User name for file permissions `root`)                                                 |
| `group`          | String | Group name for file permissions `root`)                                                |
| `path`           | String | Optional path where will be created cscan dir (default: `FARADAY_INSTALL_DIR/scripts`) |
| `git_repository` | String | cscan repository (default: `https://github.com/infobyte/cscan`)                        |
| `git_reference`  | String | cscan reference (default: `master`)                                                    |
| `ips`            | Array  | List of IPs to configure (default: `[]`)                                               |
| `websites`       | Array  | List of websites to configure (default: `[]`)                                          |
| `config`         | Hash   | Config attributes (default: `node[faraday][cscan][config]`)                            |
| `cookbook`       | String | Optional cookbook name for templates (default: `faraday`)                              |
| `crond`          | Hash   | Cron setup. These attributes will be used for `cron_d` resource (default: `{}`)        |

##### Example
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
