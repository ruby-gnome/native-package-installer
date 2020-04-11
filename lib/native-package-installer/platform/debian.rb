# Copyright (C) 2013-2019  Ruby-GNOME Project Team
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
    class Debian
      Platform.register(self)

      class << self
        def current_platform?
          return false unless File.exist?("/etc/os-release")
          File.readlines("/etc/os-release").each do |line|
            case line.chomp
            when "ID=debian"
              return true
            when "ID=raspbian"
              return true
            end
          end
          return false
        end
      end

      def package(spec)
        spec[:debian]
      end

      def install_command
        "apt install -V -y"
      end

      def need_super_user_priviledge?
        true
      end
    end
  end
end
