## Install easy-rsa package
include_recipe 'openvpn::easy_rsa'

## Install and configure OpenVPN server
node.default['openvpn']['type']                 = 'server'
node.default['openvpn']['config']['local']      = '0.0.0.0'
node.default['openvpn']['config']['proto']      = 'tcp'
node.default['openvpn']['config']['port']       = '1194'
node.default['openvpn']['config']['log']        = '/var/log/openvpn.log'
node.default['openvpn']['config']['status']     = '/var/log/openvpn_status.log'
node.default['openvpn']['subnet']               = '10.11.0.0'
node.default['openvpn']['netmask']              = '255.255.255.0'
node.default['openvpn']['key_dir']              = '/etc/openvpn/keys'
node.default['openvpn']['signing_ca_cert']      = '/etc/openvpn/keys/ca.crt'
node.default['openvpn']['signing_ca_key']       = '/etc/openvpn/keys/ca.key'
node.default['openvpn']['config']['keepalive']  = '10 60'
node.default['openvpn']['config']['persist-key']  = ''
node.default['openvpn']['config']['persist-tun']  = ''
node.default['openvpn']['config']['comp-lzo']     = ''
node.default['openvpn']['config']['reneg-sec']    = '0'
node.default['openvpn']['config']['ifconfig-pool-persist']   = 'ipp.txt'
node.default['openvpn']['config']['tun-mtu']      = '1468'
node.default['openvpn']['config']['tun-mtu-extra'] = '32'
node.default['openvpn']['config']['mssfix'] = '1400'
node.default['openvpn']['push_options'] = {
  "dhcp-option" => [
        "DNS 8.8.8.8",
        "DNS 8.8.4.4"
      ],
  "redirect-gateway" => "def1"
}

#node.default['openvpn']['gateway']              = "vpn.#{node['domain']}"
node.default['openvpn']['gateway']              = 'vpn.mobilemedic.com'

node.default['openvpn']['client_cn']            = 'dummy'

node.default['openvpn']['key']['ca_expire']     = '3650'
node.default['openvpn']['key']['expire']        = '3650'
node.default['openvpn']['key']['size']          = '1024'
node.default['openvpn']['key']['country']       = 'US'
node.default['openvpn']['key']['province']      = 'CA'
node.default['openvpn']['key']['city']          = 'Newport Beach'
node.default['openvpn']['key']['org']           = 'MobileMedic'
node.default['openvpn']['key']['email']         = 'devops@saritasa.com'
node.default['openvpn']['key']['message_digest'] = 'sha256'

include_recipe 'openvpn::server'
