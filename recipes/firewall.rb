# encoding: utf-8

node.set['shorewall']['rules'] = [
  {
    :description => 'Full access to SSH server',
    :action => :ACCEPT,
    :source => :all,
    :dest => :fw,
    :proto => :tcp,
    :dest_port => 22
  },{
    :description => 'Access to Mail Services',
    :action => :ACCEPT,
    :source => :all,
    :dest => :fw,
    :proto => :tcp,
    :dest_port => 'pop3,pop3s,imap,imaps,smtp,submission'
  },{
    :description => 'Access to Web Services',
    :action => :ACCEPT,
    :source => :all,
    :dest => :fw,
    :proto => :tcp,
    :dest_port => 'http,https'
  }
]

service 'iptables' do
  action [ :disable, :stop ]
end

include_recipe 'shorewall'
