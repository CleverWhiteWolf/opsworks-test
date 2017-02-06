## Add Docker repository
yum_repository 'docker' do
  description "Docker Main repo"
  baseurl 'https://yum.dockerproject.org/repo/main/centos/7/'
  gpgkey 'https://yum.dockerproject.org/gpg'
  action :create
end

## Install Docker
docker_installation_package 'default' do
  version '1.13.0'
  action :create
end

## Start Docker service
docker_service_manager 'default' do
  storage_driver 'devicemapper'
  action :start
end
