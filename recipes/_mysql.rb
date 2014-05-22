# encoding: utf-8

# mysql_config = data_bag_item('mysql', 'config')
mysql_creds       =  Chef::EncryptedDataBagItem.load('mysql', 'credentials')
vpopmail_db_user  =  node['qmailtoaster']['vpopmail']['database']['user']
vpopmail_db_name  =  node['qmailtoaster']['vpopmail']['database']['name']

# Install mysql gem
include_recipe 'database::mysql'

# MySQL connection information with password from data bag
mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => mysql_creds['server_root_password']
}

# Setup MySQL Service with default configuration from Chef
mysql_service 'default' do
  server_root_password mysql_creds['server_root_password']
  action :create
end

# Create default database
mysql_database vpopmail_db_name do
  connection mysql_connection_info
  action :create
end

# Create vpopmail user, we also use the password set in our data bag
mysql_database_user vpopmail_db_user do
  connection mysql_connection_info
  password   mysql_creds['server_vpopmail_password']
  database_name vpopmail_db_name
  privileges    [:all]
  action    :grant
end

# Now flush privileges so we can continue
mysql_database 'flush the privileges' do
  connection mysql_connection_info
  sql        'flush privileges'
  action     :query
end
