# encoding: utf-8

default['qmailtoaster']['packages'] = [ 'simscan', 'dovecot', 'vqadmin', 'qmailadmin', 'isoqlog', 'qmailmrtg', 'send-emails', 'squirrelmail' ]
default['qmailtoaster']['repository']['file'] = 'qmailtoaster-release-2.0-1.qt.nodist.noarch.rpm'
default['qmailtoaster']['repository']['checksum'] = 'e39fa060aa2a509e27f1739653303db90cd34e794cad920ae9fff7102c5f0ad7'
default['qmailtoaster']['repository']['url'] = 'http://mirrors.qmailtoaster.com/current/nodist'
default['qmailtoaster']['dependencies']['packages'] = [ 'man', 'yum-priorities' ]

# Some defaults
default['qmailtoaster']['vpopmail']['home'] = '/home/vpopmail'
default['qmailtoaster']['vpopmail']['database']['user'] = 'vpopmail'
default['qmailtoaster']['vpopmail']['database']['name'] = 'vpopmail'

# Web frontend is proteced by htpasswd, so we allow to change the default login
default['qmailtoaster']['htpasswd']['file'] = '/usr/share/toaster/include/admin.htpasswd'
default['qmailtoaster']['htpasswd']['user'] = 'admin'
default['qmailtoaster']['htpasswd']['passwordhash'] = '$apr1$aIG7vJT7$ZIOUh8B60XgQJWlcqlbkP1'
