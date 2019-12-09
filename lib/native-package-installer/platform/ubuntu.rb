# Copyright (C) 2013  Ruby-GNOME2 Project Team
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
    class Ubuntu < Debian
      Platform.register(self)

      class << self
        def current_platform?
          File.exist?("/etc/lsb-release")
        end
      end

      def package(spec)
        spec[:ubuntu]
      end
    end
  end
end
