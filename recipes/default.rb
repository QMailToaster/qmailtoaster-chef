# encoding: utf-8

include_recipe 'qmailtoaster::_pre'
include_recipe 'qmailtoaster::_dependencies'
include_recipe 'qmailtoaster::_mysql'
include_recipe 'qmailtoaster::_apache'
include_recipe 'qmailtoaster::_install'
include_recipe 'qmailtoaster::_post'
