#
# Cookbook Name:: postgresql
# Recipe:: server
#

include_recipe "postgresql"

# don't auto-start the service to allow custom configuration
file "/usr/sbin/policy-rc.d" do
  mode "0755"
  content("#!/bin/sh\nexit 101\n")
  not_if "pgrep postgres"
end

# install the package
case node["platform_family"]
when "ubuntu", "debian"
  package "postgresql-#{node["postgresql"]["version"]}"
when "gentoo"
  # don't use package here since apparently installing older versions of postgresql
  # will result in recompiling on _every_ run...annoying
  execute "install postgresql" do
    command "emerge -guv =dev-db/postgresql-server-#{node["postgresql"]["long_version"]}"
    action :run
  end

  eselect node["postgresql"]["version"] do
    slot "postgresql"
  end
end

# setup the data directory
include_recipe "postgresql::data_directory"

# add the configuration
include_recipe "postgresql::configuration"

# declare the system service
include_recipe "postgresql::service"

# setup users
include_recipe "postgresql::pg_user"

# setup databases
include_recipe "postgresql::pg_database"
