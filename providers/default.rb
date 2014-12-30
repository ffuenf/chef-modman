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

action :init do
  description = "initialize #{@new_resource.path} as the modman deploy root"
  converge_by(description) do
    command = "init #{@new_resource.basedir}"
    modman(command, description)
  end
end

action :list do
  description = "list all valid modules in #{@new_resource.path} that are currently checked out"
  converge_by(description) do
    command = 'list'
    command << ' --absolute' if @new_resource.absolute
    modman(command, description)
  end
end

action :status do
  description = "show VCS 'status' command for all modules in #{@new_resource.path}"
  converge_by(description) do
    command = 'status'
    modman(command, description)
  end
end

action :incoming do
  description = "show new VCS remote changesets for all VCS-based modules in #{@new_resource.path}"
  converge_by(description) do
    command = 'incoming'
    modman(command, description)
  end
end

action :updateall do
  description = "update all modules in #{@new_resource.path} that are currently checked out"
  converge_by(description) do
    command = 'update-all'
    modman(command, description)
  end
end

action :deployall do
  description = "deploy all modules in #{@new_resource.path} (no VCS interaction)"
  converge_by(description) do
    command = 'deploy-all'
    modman(command, description)
  end
end

action :repair do
  description = "rebuild all modman-created symlinks in #{@new_resource.path} (no updates performed)"
  converge_by(description) do
    command = 'repair'
    command << ' --no-local' if @new_resource.nolocal
    modman(command, description)
  end
end

action :clean do
  description = "clean up broken symlinks in #{@new_resource.path} (run this after deleting a module)"
  converge_by(description) do
    command = 'clean'
    command << ' --no-local' if @new_resource.nolocal
    command << ' --no-clean' if @new_resource.noclean
    modman(command, description)
  end
end

action :clone do
  description = "clone #{@new_resource.module} into #{@new_resource.path}/.modman"
  converge_by(description) do
    command = "clone #{@new_resource.module}"
    command << ' --no-local' if @new_resource.nolocal
    command << ' --no-clean' if @new_resource.noclean
    modman(command, description)
  end
end

action :deploy do
  description = "deploy #{@new_resource.module}"
  converge_by(description) do
    command = "deploy #{@new_resource.module}"
    command << ' --no-local' if @new_resource.nolocal
    command << ' --no-clean' if @new_resource.noclean
    modman(command, description)
  end
end

action :checkout do
  description = "checkout #{@new_resource.module} into #{@new_resource.path}/.modman"
  converge_by(description) do
    command = "checkout #{@new_resource.module}"
    command << ' --no-local' if @new_resource.nolocal
    command << ' --no-clean' if @new_resource.noclean
    modman(command, description)
  end
end

action :hgclone do
  description = "hgclone #{@new_resource.module} into #{@new_resource.path}/.modman"
  converge_by(description) do
    command = "hgclone #{@new_resource.module}"
    command << ' --no-local' if @new_resource.nolocal
    command << ' --no-clean' if @new_resource.noclean
    modman(command, description)
  end
end

action :link do
  description = "link #{@new_resource.module} into #{@new_resource.path}/.modman"
  converge_by(description) do
    command = "link #{@new_resource.module}"
    command << ' --no-local' if @new_resource.nolocal
    command << ' --no-clean' if @new_resource.noclean
    modman(command, description)
  end
end

def modman(command, description)
  command << ' --force' if new_resource.force
  script "modman: #{description}" do
    interpreter 'bash'
    user 'root'
    cwd new_resource.path
    code <<-EOF
      modman #{command}
    EOF
  end
end

def load_current_resource
  @current_resource = Chef::Resource::Modman.new(@new_resource.name)
  @current_resource.exists = true if exists?(@current_resource.path)
end

private

def exists?(path)
  ::File.exist?("#{path}/.modman")
end
