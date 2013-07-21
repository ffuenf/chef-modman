#
# Cookbook Name:: modman
# Provider:: modman
#
# Copyright 2013, Achim Rosenhagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Support whyrun
def whyrun_supported?
	true
end

action :install do
	unless @new_resource.exists
		description = "install modman in #{node["modman"]["install_path"]}"
		converge_by(description) do
			src_filename = "modman"
			src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
			remote_file src_filepath do
				source node['modman']['url']
				owner 'root'
				group 'root'
				mode 0755
			end
			bash 'install modman in #{node["modman"]["install_path"]}' do
				cwd ::File.dirname(src_filepath)
				code <<-EOH
					mv #{src_filepath} #{node["modman"]["install_path"]}/#{src_filename}
					chmod +x #{node["modman"]["install_path"]}/#{src_filename}
				EOH
			end
		end
	else
		Chef::Log.info "#{ @current_resource } already exists."
	end
end

action :init do
	if @new_resource.exists
		description = "initialize #{@new_resource.path} as the modman deploy root"
		converge_by(description) do
			command = "init #{@new_resource.basedir}"
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :list do
	if @new_resource.exists
		description = "list all valid modules in #{@new_resource.path} that are currently checked out"
		converge_by(description) do
			command = "list"
			command << " --absolute" if @new_resource.absolute
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :status do
	if @new_resource.exists
		description = "show VCS 'status' command for all modules in #{@new_resource.path}"
		converge_by(description) do
			command = "status"
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :incoming do
	if @new_resource.exists
		description = "show new VCS remote changesets for all VCS-based modules in #{@new_resource.path}"
		converge_by(description) do
			command = "incoming"
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :updateall do
	if @new_resource.exists
		description = "update all modules in #{@new_resource.path} that are currently checked out"
		converge_by(description) do
			command = "update-all"
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :deployall do
	if @new_resource.exists
		description = "deploy all modules in #{@new_resource.path} (no VCS interaction)"
		converge_by(description) do
			command = "deploy-all"
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :repair do
	if @new_resource.exists
		description = "rebuild all modman-created symlinks in #{@new_resource.path} (no updates performed)"
		converge_by(description) do
			command = "repair"
			command << " --no-local" if @new_resource.nolocal
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :clean do
	if @new_resource.exists
		description = "clean up broken symlinks in #{@new_resource.path} (run this after deleting a module)"
		converge_by(description) do
			command = "clean"
			command << " --no-local" if @new_resource.nolocal
			command << " --no-clean" if @new_resource.noclean
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :clone do
	if @new_resource.exists
		description = "clone #{@new_resource.module} into #{@new_resource.path}/.modman"
		converge_by(description) do
			command = "clone #{@new_resource.module}"
			command << " --no-local" if @new_resource.nolocal
			command << " --no-clean" if @new_resource.noclean
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :deploy do
	if @new_resource.exists
		description = "deploy #{@new_resource.module}"
		converge_by(description) do
			command = "deploy #{@new_resource.module}"
			command << " --no-local" if @new_resource.nolocal
			command << " --no-clean" if @new_resource.noclean
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :checkout do
	if @new_resource.exists
		description = "checkout #{@new_resource.module} into #{@new_resource.path}/.modman"
		converge_by(description) do
			command = "checkout #{@new_resource.module}"
			command << " --no-local" if @new_resource.nolocal
			command << " --no-clean" if @new_resource.noclean
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :hgclone do
	if @new_resource.exists
		description = "hgclone #{@new_resource.module} into #{@new_resource.path}/.modman"
		converge_by(description) do
			command = "hgclone #{@new_resource.module}"
			command << " --no-local" if @new_resource.nolocal
			command << " --no-clean" if @new_resource.noclean
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end

action :link do
	if @new_resource.exists
		description = "link #{@new_resource.module} into #{@new_resource.path}/.modman"
		converge_by(description) do
			command = "link #{@new_resource.module}"
			command << " --no-local" if @new_resource.nolocal
			command << " --no-clean" if @new_resource.noclean
		end
	else
		Chef::Log.info "#{ @current_resource } doesn't exist."
	end
end


def modman(command, description)
	command << " --force" if new_resource.force
	script "modman: #{command}" do
		interpreter 'bash'
		user "root"
		cwd new_resource.path
		code <<-EOF
			modman #{command}
		EOF
	end
end

def load_current_resource
	@current_resource = Chef::Resource::Modman.new(@new_resource.name)
	
	if exists?(@current_resource.path)
		@current_resource.exists = true
	end
end

private
def exists?(path)
	begin
		::File.exists?("#{path}/.modman")
	rescue Chef::Exceptions::ShellCommandFailed
	rescue Mixlib::ShellOut::ShellCommandFailed
		false
	end
end