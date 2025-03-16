# Copyright (C) 2013-2025  Ruby-GNOME Project Team
#
# This library is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

lib_dir = File.join(File.dirname(__FILE__), "lib")
$LOAD_PATH.unshift(lib_dir)

require "native-package-installer/version"

Gem::Specification.new do |spec|
  spec.name = "native-package-installer"
  spec.version = NativePackageInstaller::VERSION
  spec.authors = ["Sutou Kouhei"]
  spec.email = ["kou@clear-code.com"]
  spec.summary = "Deprecated. Use rubygems-requirements-system instead. native-package-installer helps to install native packages on \"gem install\"."
  spec.description = <<-DESCRIPTION.strip
Deprecated. Use rubygems-requirements-system instead.

Users need to install native packages to install an extension library
that depends on native packages. It bores users because users need to
install native packages and an extension library separately.

native-package-installer helps to install native packages on "gem install".
Users can install both native packages and an extension library by one action,
"gem install".
  DESCRIPTION
  spec.homepage = "https://github.com/ruby-gnome/native-package-installer"
  spec.licenses = ["LGPL-3-or-later"]
  spec.require_paths = ["lib"]

  spec.files = ["README.md", "Rakefile"]
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("doc/text/**/*.*")

  spec.add_runtime_dependency("rubygems-requirements-system")
end
