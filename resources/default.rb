actions :install, :init, :list, :status, :incoming, :updateall, :deployall, :repair, :clean
default_action :install

attribute :path, :kind_of => String, :name_attribute => true
attribute :basedir, :kind_of => String
attribute :absolute, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :nolocal, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :noclean, :kind_of => [ TrueClass, FalseClass ], :default => false

attr_accessor :exists