# Copyright (C) 2019  Ruby-GNOME Project Team
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

require "native-package-installer/platform/debian"

class NativePackageInstaller
  module Platform
    class Ubuntu < Debian
      Platform.register(self)

      class << self
        def current_platform?
          return false unless File.exist?("/etc/lsb-release")
          File.readlines("/etc/lsb-release").any? do |line|
            line.chomp == "DISTRIB_ID=Ubuntu"
          end
        end
      end

      def package(spec)
        spec[:ubuntu] || spec[:debian]
      end
    end
  end
end
