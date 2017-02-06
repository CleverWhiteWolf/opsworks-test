## Install FreeRADIUS packages
package 'Install FreeRADIUS packages' do
  case node[:platform]
  when 'redhat', 'centos', 'amazon'
    package_name ['freeradius','freeradius-utils','freeradius-python','freeradius-perl','freeradius-ldap','freeradius-doc','freeradius-devel']
  end
end

service 'radiusd' do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

## Create directory for compiling radiusplugin
directory '/usr/src/apps' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

## Create directory for storing radiusplugin
directory '/etc/openvpn/radius' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

## Compile radiusplugin
bash 'Compile radiusplugin' do
  user 'root'
  cwd '/usr/src/apps'
  code <<-EOH
  wget http://www.nongnu.org/radiusplugin/radiusplugin_v2.1a_beta1.tar.gz
  tar xvf radiusplugin_v2.1a_beta1.tar.gz
  cd radiusplugin_v2.1a_beta1
  make
  cp -r radiusplugin.so /etc/openvpn/radius
  EOH
  not_if { ::File.exist?("/etc/openvpn/radius/radiusplugin.so") }
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/raddb/users")
    file.insert_line_if_no_match("/users.custom/","$INCLUDE /etc/raddb/users.custom")
    file.write_file
  end
end

template '/etc/raddb/users.custom' do
  source 'users.custom.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[radiusd]', :delayed
end
