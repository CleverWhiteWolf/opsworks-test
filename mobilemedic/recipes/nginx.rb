## Nginx installation
package 'Install Nginx' do
  case node[:platform]
  when 'redhat', 'centos', 'amazon'
    package_name ['nginx']
  end
end

## Provisioning Nginx service
template '/etc/nginx/nginx.conf' do
  source 'nginx.rb'
  notifies :reload, 'service[nginx]', :delayed
end

template '/etc/nginx/conf.d/jenkins.conf' do
  source 'nginx_jenkins.rb'
  notifies :reload, 'service[nginx]', :delayed
end

## Enable and start Nginx service
service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
