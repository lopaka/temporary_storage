#
# Cookbook Name:: temporary_storage
# Attribute:: default
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

# The mount point where the device will be mounted
default['temporary_storage']['mount_point'] = '/mnt/storage'

# Size of the volume to be created
default['temporary_storage']['volume_size'] = 10

# Volume type
default['temporary_storage']['volume_type'] = nil
