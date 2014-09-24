#
# Cookbook Name:: temporary_storage
# Recipe:: decommission
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

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

# Continue only if on vsphere.
unless node['cloud']['provider'] == 'vsphere'
  log 'Temporary volumes not used on this cloud.'
  return
end

# Detach and delete the temporary volumes
device_nickname = node['temporary_storage']['nickname']

# Unmount the volume
log "Unmounting #{node['temporary_storage']['mount_point']}"

# There might still be some open files from the mount point. Just ignore the failure for now.
mount node['temporary_storage']['mount_point'] do
  device lazy { node['rightscale_volume'][device_nickname]['device'] }
  ignore_failure true
  action [:umount, :disable]
  only_if { node.attribute?('rightscale_volume') && node['rightscale_volume'].attribute?(device_nickname) }
end

# Detach and delete the volume
rightscale_volume device_nickname do
  action [:detach, :delete]
end
