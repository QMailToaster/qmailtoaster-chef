# Description

This Chef cookbook will allow you to deploy QMail Toaster on a CentOS 6
system with ease.

This is a project under development and not meant for production servers
yet. Feedback and test experience are welcome through the issue tracker!

# Requirements

## System

* CentOS 6.x

## Cookbooks

* apache2
* mysql
* and more, see metadata for details

**Note**: Shorewall is used when running the firewall recipe. Please ensure
you supply the version documented in the Berksfile since it adds some
customizations to work with CentOS.

# Recipes

* default
* firewall

## Default

Installs and configures a qmailtoaster system.

## Firewall

Adds some additional firewalling. This is an extra recipe to allow
administrators to use their own implementations. It will only allow
access to QMailtoaster related ports.

# Kitchen

This cookbook comes with a Kitchen configuration. If you would like to
give it a whirl install

* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [Chef DK](http://www.getchef.com/downloads/chef-dk/)

Windows user must be patient, a Chef DK including Kitchen will be
released soon.

In order to run this cookbook you need to:

* Install Vagrant, Virtualbox and Chef DK
* Check out the repository
* Run `kitchen converge`

Depending on the state of this cookbook you may (or may not) have a
fully installed machine available.

# Testing

This cookbook comes with serverspec tests supplied via `kitchen verify`.
To run all test suites use `kitchen test`. This will create the machine,
install and configure everything and then destory it when passing all
tests.

# Contributing

See supplied `CONTRIBUTING.md` in this repository.

# License and Author

* Author::, Sebastian Grewe (sebastian.grewe@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
