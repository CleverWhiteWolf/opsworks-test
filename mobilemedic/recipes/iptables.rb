## Install Iptables packages
package 'Install Iptables packages' do
  case node[:platform]
  when 'redhat', 'centos', 'amazon'
    package_name ['iptables','iptables-utils','iptables-services']
  end
end

service 'iptables' do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
