#
# Cookbook Name:: postgresql
# Recipe:: portage_repository
#

# enable base package
enable_package "dev-db/postgresql-base" do
  version node["postgresql"]["long_version"]
end

# enable server package
enable_package "dev-db/postgresql-server" do
  version node["postgresql"]["long_version"]
end

# enable additional libraries required
enable_package "dev-libs/ossp-uuid" do
  version "1.6*"
end
