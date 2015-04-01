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
- Debian 7

Attributes
----------
#### faraday::default
<table>
<tr>
<th>Key</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
<tr>
<td><tt>['faraday']['git_repository']</tt></td>
<td>String</td>
<td>Faraday repository to fetch</td>
<td><tt>https://github.com/infobyte/faraday</tt></td>
</tr>
<tr>
<td><tt>['faraday']['git_reference']</tt></td>
<td>String</td>
<td>Git reference to fetch</td>
<td><tt>master</tt></td>
</tr>
<tr>
<td><tt>['faraday']['install_dir']</tt></td>
<td>String</td>
<td>Directory where Faraday will be stored</td>
<td><tt>/opt/faraday</tt></td>
</tr>
<tr>
<td><tt>['faraday']['packages']</tt></td>
<td>String</td>
<td>Package to install</td>
<td><tt>git-core ipython python-pip python-dev</tt></td>
</tr>
<tr>
<td><tt>['faraday']['pip_packages']</tt></td>
<td>String</td>
<td>Python package to install</td>
<td><tt>couchdbkit mockito whoosh restkit flask</tt></td>
</tr>
</table>

#### faraday::config
<table>
<tr>
<th>Key</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
<tr>
<td><tt>['faraday']['user']</tt></td>
<td>String</td>
<td>User to set configuration, must exists.</td>
<td><tt>root</tt></td>
</tr>
<tr>
<td><tt>['faraday']['group']</tt></td>
<td>String</td>
<td>Group for file permission, must exists.</td>
<td><tt>root</tt></td>
</tr>
<tr>
<td><tt>['faraday']['home']</tt></td>
<td>String</td>
<td>User's home directory</td>
<td><tt>/root</tt></td>
</tr>
</table>

All others attributes in `['faraday']['config']` namespace will generate dynamically the
configuration file as XML format in `$HOME/.faraday/config/config.xml`.

Use the `['faraday']['config_attrs']` namespace to set xml attributes. See `attributes/config.rb` for more details.

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
