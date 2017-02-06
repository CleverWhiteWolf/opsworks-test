## Enable EPEL release
include_recipe 'yum-epel'
node.default['yum']['epel']['enabled'] = true
node.default['yum']['epel']['managed'] = true

## Install meta package 'Development Tools'
include_recipe 'yumgroup'

yumgroup 'Development Tools' do
  action :install
end

## Install base packages
package 'Install base packages' do
  case node[:platform]
  when 'redhat', 'centos', 'amazon'
    package_name ['git','mc','tcpdump','zsh','iftop','iotop','htop','yum-cron','libcurl-devel','rubygem-rake','libgcrypt','libgcrypt-devel','gcc-c++']
  end
end
