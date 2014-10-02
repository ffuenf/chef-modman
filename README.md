chef-modman
===========
[![GitHub tag](http://img.shields.io/github/tag/ffuenf/chef-modman.svg)][tag]
[![Build Status](http://img.shields.io/travis/ffuenf/chef-modman.svg)][travis]
[![Gittip](http://img.shields.io/gittip/arosenhagen.svg)][gittip]

[tag]: https://github.com/ffuenf/chef-modman/tags
[travis]: https://travis-ci.org/ffuenf/chef-modman
[gittip]: https://www.gittip.com/arosenhagen

chef-modman installs [modman](https://github.com/colinmollenhour/modman) and provides access to a corresponding LWRP.

Dependencies
------------

This cookbook has no direct dependencies.


Description
===========

Installs [modman](https://github.com/colinmollenhour/modman) and provides access to a corresponding LWRP.

Platform
--------

The following platforms are supported and tested:

* Debian 6.x
* Debian 7.x
* Ubuntu 14.04.x

Other Debian family distributions are assumed to work.

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

Development
-----------
1. Fork the repository from GitHub.
2. Clone your fork to your local machine:

        $ git clone git@github.com:USER/chef-modman.git

3. Create a git branch

        $ git checkout -b my_bug_fix

4. **Write tests**
5. Make your changes/patches/fixes, committing appropriately
6. Run the tests: `rake style`, `rake spec`, `rake integration:vagrant`
7. Push your changes to GitHub
8. Open a Pull Request

Testing
-------

The following Rake tasks are provided for automated testing of the cookbook:

```
$ rake -T
rake spec                 # Run ChefSpec examples
rake style                # Run all style checks
rake style:chef           # Lint Chef cookbooks
rake style:ruby           # Run Ruby style checks
rake travis               # Run all tests on Travis
```
See TESTING.md for detailed information.

License and Author
------------------

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2014, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
