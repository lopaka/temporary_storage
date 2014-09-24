#
# Cookbook Name:: temporary_storage
# Recipe:: volume
#
# Copyright (C) 2014 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

# Continue only if on vsphere.
unless node['cloud']['provider'] == 'vsphere'
  log 'Temporary volumes not used on this cloud.'
  return
end

device_nickname = node['temporary_storage']['nickname']
size = node['temporary_storage']['volume_size'].to_i

volume_options = {}
volume_options[:volume_type] = node['temporary_storage']['volume_type']
volume_options[:controller_type] = node['temporary_storage']['controller_type'] if node['temporary_storage']['controller_type']

log "Creating new temporary volume '#{device_nickname}' with size #{size}"
rightscale_volume device_nickname do
  size size
  options volume_options
  action [:create, :attach]
end

filesystem device_nickname do
  fstype node['temporary_storage']['filesystem']
  device lazy { node['rightscale_volume'][device_nickname]['device'] }
  mkfs_options node['temporary_storage']['mkfs_options']
  mount node['temporary_storage']['mount_point']
  action [:create, :enable, :mount]
end
