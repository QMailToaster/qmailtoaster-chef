# encoding: utf-8
require 'serverspec'
include Serverspec::Helper::Exec

# Things to test
services = %w(qmail dovecot)
ports = [80, 443, 110, 995, 143, 993, 25, 587]
domain = 'test-domain.org'
user = 'test'

# Some functionality tests we do against our installation
commands = [
  ['yum -y install mailx', 0],
  ["mysql -u root -psomeRandomDataBagPassword -e 'show databases;' | grep vpopmail", 0],
  ["/home/vpopmail/bin/vadddomain #{domain} testpass", 0],
  ["/home/vpopmail/bin/vadddomain #{domain} testpass", 243],
  ["/home/vpopmail/bin/vadduser #{user}@#{domain} testpass2", 0],
  ["/home/vpopmail/bin/vadduser #{user}@#{domain} testpass2", 255],
  ["/home/vpopmail/bin/vdeluser #{user}@#{domain}", 0],
  ["/home/vpopmail/bin/vdeluser #{user}@#{domain}", 246],
  ["/home/vpopmail/bin/vdeldomain #{domain}", 0],
  ["/home/vpopmail/bin/vdeldomain #{domain}", 245],
  ["curl -s -I http://localhost/admin-toaster/ | grep 'HTTP/1.1 401 Authorization Required'", 0],
  ["curl -s -I http://admin:admin@localhost/admin-toaster/ | grep 'HTTP/1.1 200 OK'", 0],
  ["curl -s -I http://localhost/qlogs-toaster/ | grep 'HTTP/1.1 401 Authorization Required'", 0],
  ["curl -s -I http://admin:admin@localhost/qlogs-toaster/ | grep 'HTTP/1.1 200 OK'", 0],
  ["curl -s -I http://localhost/stats-toaster/ | grep 'HTTP/1.1 401 Authorization Required'", 0],
  ["curl -s -I http://localhost/qmailadmin/ | grep 'HTTP/1.1 200 OK'", 0],
  ["curl -s -I http://admin:admin@localhost/stats-toaster/ | grep 'HTTP/1.1 200 OK'", 0],
  ["curl -s -I http://localhost/mail/vqadmin/toaster.vqadmin | grep 'HTTP/1.1 401 Authorization Required'", 0],
  ["curl -s -I http://admin:admin@localhost/mail/vqadmin/toaster.vqadmin | grep 'HTTP/1.1 200 OK'", 0],
  ["curl -s -I http://localhost/admin-toaster/admin-toaster/email/ | grep 'HTTP/1.1 401 Authorization Required'", 0],
  ["curl -s -I http://admin:admin@localhost/admin-toaster/email/ | grep 'HTTP/1.1 200 OK'", 0],
  ["curl -s -X POST --data-urlencode 'dname=curl-domain-test.org&pp=testpass&nav=add_domain&lusers=&lfor=&lalias=&lresponder=&llists=&quota=NOQUOTA&Submit=Add+Domain' http://admin:admin@localhost/mail/vqadmin/toaster.vqadmin", 0],
  ["curl -s -X POST --data-urlencode 'dname=&Submit=List+Domains&nav=list_domains' http://admin:admin@localhost/mail/vqadmin/toaster.vqadmin | grep curl-domain-test.org", 0],
  ["curl -s -X POST --data 'address=postmaster%40curl-domain-test.org&oldpass=testpass&newpass1=testpass2&newpass2=testpass2&returntext=&returnhttp=' http://localhost/qmailadmin/index.cgi/passwd/ | grep \"password changed successfully\"", 0],
  ["curl -s -X POST --data 'address=postmaster%40curl-domain-test.org&oldpass=testpass&newpass1=testpass2&newpass2=testpass2&returntext=&returnhttp=' http://localhost/qmailadmin/index.cgi/passwd/ | grep \"Invalid Login\"", 0],
  ["echo test | mail -s 'Test' postmaster@curl-domain-test.org && sleep 3 && grep test /home/vpopmail/domains/curl-domain-test.org/postmaster/Maildir/new/\*", 0],
  ["curl -s -X POST --data-urlencode 'dname=curl-domain-test.org&Submit=Delete+Domain+&nav=del_domain' http://admin:admin@localhost/mail/vqadmin/toaster.vqadmin", 0],
  ["curl -s -X POST --data-urlencode 'dname=&Submit=List+Domains&nav=list_domains' http://admin:admin@localhost/mail/vqadmin/toaster.vqadmin | grep curl-domain-test.org", 1],
]

services.each do |svc|
  describe service(svc) do
    # NotImplementedError so not checked yet
    # it { should be_enabled.with_level(3) }
    it { should be_running }
  end
end

ports.each do |port|
  describe port(port) do
    it { should be_listening }
  end
end

commands.each do |cmd, code|
  describe command(cmd) do
    it { should return_exit_status code }
  end
end
