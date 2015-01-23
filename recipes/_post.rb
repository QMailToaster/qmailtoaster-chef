# encoding: utf-8

# We now deploy our vpopmail password so vpopmail has access to the database
mysql_creds       =  Chef::EncryptedDataBagItem.load('mysql', 'credentials')
template node['qmailtoaster']['vpopmail']['home'] + '/etc/vpopmail.mysql' do
  source 'vpopmail/vpopmail.mysql.erb'
  variables(
    'password' => mysql_creds['server_vpopmail_password'],
    'user' => node['qmailtoaster']['vpopmail']['database']['user'],
    'database' => node['qmailtoaster']['vpopmail']['database']['name']
  )
end

# deploy our admin account into the htpasswd file
file node['qmailtoaster']['htpasswd']['file'] do
  content node['qmailtoaster']['htpasswd']['user'] + ':' +
    node['qmailtoaster']['htpasswd']['passwordhash']
end

# Workaround for apache configs not being loaded due to apaches conf.d folder
link '/etc/httpd/conf.d/toaster.conf' do
  to '/etc/httpd/conf/toaster.conf'
  notifies :reload, 'service[httpd]', :delayed
end
link '/etc/httpd/conf.d/squirrelmail.conf' do
  to '/etc/httpd/conf/squirrelmail.conf'
  notifies :reload, 'service[httpd]', :delayed
end
# Fix for missing sendmail link
link '/usr/sbin/sendmail' do
  to '/var/qmail/bin/sendmail'
end

# We have to run sa-update to ensure files exist before starting spamd
bash 'run_sa-update' do
  user 'root'
  cwd '/tmp'
  code "sa-update"
  not_if { ::File.exist?('/var/lib/spamassassin') }
end

# Enable and start all services
service 'qmail' do
  action [:enable, :start]
end

service 'httpd' do
  action [:enable, :start]
end

service 'dovecot' do
  action [:enable, :start]
end

service 'clamd' do
  action [:enable, :start]
end

service 'spamd' do
  action [:enable, :start]
end
