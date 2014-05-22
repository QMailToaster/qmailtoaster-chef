# encoding: utf-8

# Install and configure apache for qmailtoaster
include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_alias'
include_recipe 'apache2::mod_cgi'
