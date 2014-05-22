# encoding: utf-8

# Prepare CentOS Base System with our requirements

include_recipe 'selinux::disabled'
include_recipe 'ntp'
include_recipe 'yum-repoforge'
