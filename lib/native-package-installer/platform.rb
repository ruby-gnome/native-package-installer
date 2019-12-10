# Copyright (C) 2017-2019  Ruby-GNOME Project Team
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

class NativePackageInstaller
  module Platform
    PLATFORM_CLASSES = []

    class << self
      def register(platform_class)
        PLATFORM_CLASSES << platform_class
      end

      def detect
        platform_class = PLATFORM_CLASSES.find do |platform_class|
          platform_class.current_platform?
        end
        platform_class ||= Unknown
        platform_class.new
      end
    end
  end
end

require "native-package-installer/platform/msys2"

require "native-package-installer/platform/freebsd"

require "native-package-installer/platform/alt-linux"
require "native-package-installer/platform/arch-linux"
require "native-package-installer/platform/debian"
require "native-package-installer/platform/fedora"
require "native-package-installer/platform/pld-linux"
require "native-package-installer/platform/redhat"
require "native-package-installer/platform/suse"
require "native-package-installer/platform/ubuntu"

require "native-package-installer/platform/homebrew"

require "native-package-installer/platform/macports"

require "native-package-installer/platform/unknown"
