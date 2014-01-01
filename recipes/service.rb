#
# Cookbook Name:: postgresql
# Recipe:: service
#


file "/usr/sbin/policy-rc.d" do
  action :delete
end

postgresql_service = case node["platform_family"]
                     when "ubuntu", "debian"
                       "postgresql"
                     when "gentoo"
                       "postgresql-#{node["postgresql"]["version"]}"
                     end

# define the service
service "postgresql" do
  supports restart: true
  service_name postgresql_service
  action [:enable, :start]
end
