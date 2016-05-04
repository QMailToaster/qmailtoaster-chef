# encoding: utf-8
# We need this for mysql_* calls to work
mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mariadb if node['qmailtoaster']['mariadb']
end

# Load some basic information (encrypted and unencrypted)
mysql_creds       =  Chef::EncryptedDataBagItem.load('mysql', 'credentials')
vpopmail_db_user  =  node['qmailtoaster']['vpopmail']['database']['user']
vpopmail_db_name  =  node['qmailtoaster']['vpopmail']['database']['name']

# Some specials for MariaDB if enabled
if node['qmailtoaster']['mariadb']
  node.set['mariadb']['server_root_password'] = mysql_creds['server_root_password']
  include_recipe 'mariadb::server'
end

# MySQL connection information with password from data bag
mysql_connection_info = {
  host: '127.0.0.1',
  username: 'root',
  password: mysql_creds['server_root_password']
}

# Setup MySQL Service with default configuration from Chef
# Only If we don't run MariaDB
mysql_service 'default' do
  initial_root_password mysql_creds['server_root_password']
  action [:create, :start]
  not_if { node['qmailtoaster']['mariadb'] }
end

# Create default database
mysql_database vpopmail_db_name do
  connection mysql_connection_info
  action :create
end

# Create vpopmail user, we also use the password set in our data bag
mysql_database_user vpopmail_db_user do
  connection mysql_connection_info
  password mysql_creds['server_vpopmail_password']
  database_name vpopmail_db_name
  privileges [:all]
  action :grant
end
