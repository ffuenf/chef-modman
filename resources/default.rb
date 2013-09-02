actions :install, :init, :list, :status, :incoming, :updateall, :deployall, :repair, :clean, :deploy, :clone, :hgclone, :checkout, :link 
default_action :install

attribute :module, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => String
attribute :basedir, :kind_of => String
attribute :absolute, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :nolocal, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :noclean, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :force, :kind_of => [ TrueClass, FalseClass ], :default => false

attr_accessor :exists