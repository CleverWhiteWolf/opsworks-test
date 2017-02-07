## Get information about hostname
include_recipe 'ohai'
include_recipe 'aws'
include_recipe 'route53'

## Get information about domain used for creating dynamic DNS records
# This information is provided through the Custom JSON of OpsWorks layer
## We need to download data about the instance from AWS OpsWorks Data Bag
instance = search("aws_opsworks_instance").first

## Create EC2 Tag named CNAME with a value of subdomain based on hostname and domain
aws_resource_tag node['ec2']['instance_id'] do
  tags('CNAME' => "#{node['hostname']}.#{node['ddns-domain']}.")
  action :update
end

route53_record "create a record" do
  name      "#{node['hostname']}.#{node['ddns-domain']}."
  value     "#{instance['private_dns']}"
  type      "CNAME"
  ttl       60

  zone_id   node['ddns-zone-id']
  overwrite true
  fail_on_error true
  action :create
end
