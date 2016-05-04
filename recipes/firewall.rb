# encoding: utf-8
# Enable default firewall service
include_recipe 'firewall'

# Open specific ports for Toaster Host
firewall_rule 'http/https' do
  protocol  :tcp
  source    '0.0.0.0/0'
  port      %w(80 443)
  command   :allow
end

firewall_rule 'qmailtoaster' do
  protocol  :tcp
  source    '0.0.0.0/0'
  port      %w(110 995 143 993 25 587)
end
