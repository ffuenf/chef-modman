Description
===========

Installs [modman](https://github.com/colinmollenhour/modman) and provides access to a corresponding LWRP.

Requirements
============

This Cookbook is only useful when dealing with [magento](http://www.magentocommerce.com/). Therefore you must have a complete magento installation running to use this cookbook and its associated LWRP.

Attributes
==========

* `node['modman']['url']` - default: 'https://raw.github.com/colinmollenhour/modman/master/modman'
* `node['modman']['install_path']` - default: '/usr/local/bin'

Usage
=====

Simply include the recipe in your application recipe, where you setup/deploy magento.
```ruby
include_recipe "modman"
```

ATTENTION: name this cookbook "modman" if you want to use the LWRP like this:
```ruby
modman "MODULENAME" do
	path "/MAGENTO_ROOT"
	action :clone
end
```

See [Command-Reference](https://github.com/colinmollenhour/modman) for available commands.
Keep an eye on the associated actions in the LWRP (providers/default.rb) since some commands had to be rewritten using no "-".

As a sidenote for [vagrant](http://www.vagrantup.com) users: - You may set up a bash function to use a pseudo-tty with magerun in the vagrant box.

e.g. in your local `~/.bash_profile` place:
```bash
modman () {
  vagrant ssh -- -t modman $@
}
```

Open a new bash prompt at your Vagrant project and interact with n98-magerun as if it were local.
```
$ modman help
$ modman deploy-all
```

Your commands will be run inside the Vagrant box.

License and Author
==================

Author of modman:: Colin Mollenhour
Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

Copyright:: 2013, Achim Rosenhagen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.