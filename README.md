# Chef Repo

[![Build Status](https://travis-ci.org/sweeperio/chef-repo.svg?branch=master)](https://travis-ci.org/sweeperio/chef-repo)

This is the main chef repo for the sweeper.io organization. Data bags, roles, environments and tests are stored here.
_**Cookbooks should not be added to this repo.**_

## Setup

### Install the ChefDK and Flay

Head over to the [ChefDK] site and download/install the current version for your platform. After installing [ChefDK],
you'll need to install [Flay] by running `chef gem install chef-flavor-flay`.

### Configure Knife, Etc.

In order to work with our chef server, you'll need some common files (validator.pem, chef plugins, etc.). Instead of
storing these per repo, or in the global `~/.chef` directory, we've elected to use our own folder. This will allow you
to continue to use `~/.chef` for your supermarket account or your own chef repo.

To get started, you'll need to:

* Have someone create a client for your node (for `node_name` and `client_key` settings in _knife.rb_)
* Untar our `chef-sweeper` tarball to `~/.chef-sweeper`
* Add your client pem file to `~/.chef-sweeper` and update the `node_name` and `client_key` attributes appropriately
* Run `flay link` from this directory

[ChefDK]: https://downloads.chef.io/chef-dk/
[Flay]: https://github.com/sweeperio/flay

## Data Bags

Normally chef works by communicating directly with the server for data bags. However, I'd prefer to store these in
json files within the repo. This gives us the ability to use git for version history.

To manage encryption, you can use [Flay].

### Creating a New Data Bag

* Create a json file for the item (e.g. _data_bags/[BAG_NAME]/[ITEM].json_)
* Add any plain text entries needed
* Run `flay encrypt [BAG_NAME] [ITEM]`
* `knife data bag from file data_bags/[BAG_NAME]/[ITEM].json`

### Editing a Data Bag

* Decrypt the file with `flay decrypt [BAG_NAME] [ITEM]`
* Update the JSON file as needed
* Encrypt the file `flay encrypt [BAG_NAME] [ITEM]`
* `knife data bag from file data_bags/[BAG_NAME]/[ITEM].json`

### Deleting a Data Bag

* `git rm data_bags/[BAG_NAME]/[ITEM].json`
* `knife data bag delete BAG_NAME ITEM`
