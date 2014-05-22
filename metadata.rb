name              'qmailtoaster'
maintainer        'Sebastian Grewe'
maintainer_email  'sebastian.grewe@gmail.com'
license           'Apache 2.0'
description       'Installs/configures qmailtoaster from binary packages supplied by the QMailtoaster Project'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'
recipe            'qmailtoaster::default', 'Installs/configures qmailtoaster'
recipe            'qmailtoaster::firewall', 'Installs/configures basic Shorewall firewall'

supports 'centos', '>= 6.4'

depends 'apache2', '~> 1.10.0'
depends 'database', '~> 2.2.0'
depends 'iptables', '~> 0.13.0'
depends 'mysql', '~> 5.2.0'
depends 'mysql-chef_gem', '~> 0.0.2'
depends 'ntp', '~> 1.6.0'
depends 'selinux', '~> 0.8.0'
depends 'shorewall', '~> 0.0.19'
depends 'yum', '~> 3.2.0'
depends 'yum-epel', '~> 0.3.6'
depends 'yum-repoforge', '~> 0.2.0'
