# encoding: utf-8
default['qmailtoaster']['packages'] = [ 'simscan', 'dovecot', 'vqadmin', 'qmailadmin', 'isoqlog', 'qmailmrtg', 'send-emails', 'squirrelmail' ]

case node['platform_version'].to_i
when 6
  default['qmailtoaster']['mariadb'] = false
  default['qmailtoaster']['repository']['file'] = 'qmailtoaster-release-2.0-1.qt.nodist.noarch.rpm'
  default['qmailtoaster']['repository']['checksum'] = 'e39fa060aa2a509e27f1739653303db90cd34e794cad920ae9fff7102c5f0ad7'
  default['qmailtoaster']['repository']['url'] = 'http://mirrors.qmailtoaster.com/current/nodist'
when 7
  default['qmailtoaster']['mariadb'] = true
  default['qmailtoaster']['repository']['file'] = 'whtc-qmt-1-1.qt.el7.noarch.rpm'
  default['qmailtoaster']['repository']['checksum'] = '05c531e35980b5b252597da383d583349ecc4d4761cbb11b270c85d2c8870ce3'
  default['qmailtoaster']['repository']['url'] = 'ftp://ftp.whitehorsetc.com/pub/repo/qmt/CentOS/7/current/noarch'
end
default['qmailtoaster']['dependencies']['packages'] = [ 'man', 'yum-priorities' ]
default['mariadb']['install']['prefer_os_package'] = true if node['qmailtoaster']['mariadb']

# Some defaults
default['qmailtoaster']['vpopmail']['home'] = '/home/vpopmail'
default['qmailtoaster']['vpopmail']['database']['user'] = 'vpopmail'
default['qmailtoaster']['vpopmail']['database']['name'] = 'vpopmail'

# Web frontend is proteced by htpasswd, so we allow to change the default login
default['qmailtoaster']['htpasswd']['file'] = '/usr/share/toaster/include/admin.htpasswd'
default['qmailtoaster']['htpasswd']['user'] = 'admin'
default['qmailtoaster']['htpasswd']['passwordhash'] = '$apr1$aIG7vJT7$ZIOUh8B60XgQJWlcqlbkP1'

# Firewalling changes to ensure access
default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
