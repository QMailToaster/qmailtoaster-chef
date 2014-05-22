# encoding: utf-8

node['qmailtoaster']['packages'].each do |pkg|
  package pkg
end
