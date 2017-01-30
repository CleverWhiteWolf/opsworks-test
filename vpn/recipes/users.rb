## Generate certificate for user Dummy
client=node['openvpn']['client_cn']
gateway=node['openvpn']['gateway']

bash 'Create certificate' do
  action :run
  code <<-EOH
  (cd /etc/openvpn/easy-rsa && source ./vars && rake client name=#{client} gateway=#{gateway})
  EOH
end
