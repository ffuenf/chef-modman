maintainer 'Achim Rosenhagen'
maintainer_email 'a.rosenhagen@ffuenf.de'
license 'Apache 2.0'
description 'installs/configures modman'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name 'modman'
version '2.2.0'

%w(debian ubuntu).each do |os|
  supports os
end
