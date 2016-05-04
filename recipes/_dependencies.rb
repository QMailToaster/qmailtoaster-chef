# encoding: utf-8
download_url = "#{node['qmailtoaster']['repository']['url']}/" +
               node['qmailtoaster']['repository']['file']
destination_file = "#{Chef::Config[:file_cache_path]}/" +
                   node['qmailtoaster']['repository']['file']

# Install packages required by qmailtoaster
node['qmailtoaster']['dependencies']['packages'].each do |pkg|
  package pkg
end

# Install qmailtoaster repository
remote_file destination_file do
  source download_url
  checksum node['qmailtoaster']['repository']['checksum']
  notifies :install, 'rpm_package[qmailtoaster-release]', :immediately
end
rpm_package 'qmailtoaster-release' do
  source destination_file
end

# Other packages
package 'qmailtoaster-util' do
  only_if { node['platform_version'].to_i < 7 }
end
