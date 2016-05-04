name              'qmailtoaster'
maintainer        'Sebastian Grewe'
maintainer_email  'sebastian.grewe@gmail.com'
issues_url        'https://github.com/QMailToaster/qmailtoaster-chef/issues' if respond_to?(:issues_url)
source_url        'https://github.com/QMailToaster/qmailtoaster-chef' if respond_to?(:source_url)
license           'Apache 2.0'
description       'Installs/configures qmailtoaster from binary packages supplied by the QMailtoaster Project'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'
recipe            'qmailtoaster::default', 'Installs/configures qmailtoaster'
recipe            'qmailtoaster::firewall', 'Installs/configures basic Shorewall firewall'

supports 'centos', '>= 6.4'

depends 'apache2'
depends 'database'
depends 'mysql'
depends 'mariadb'
depends 'mysql2_chef_gem'
depends 'ntp'
depends 'selinux'
depends 'firewall'
depends 'yum'
depends 'yum-epel'
depends 'yum-repoforge'
