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
    class RedHat
      Platform.register(self)

      class << self
        def current_platform?
          File.exist?("/etc/redhat-release")
        end
      end

      def package(spec)
        spec[:redhat]
      end

      def install_command
        if major_version >= 8
          "dnf install --enablerepo=powertools -y"
        else
          "yum install -y"
        end
      end

      def need_super_user_priviledge?
        true
      end

      private
      def major_version
        major_version_string = File.read("/etc/redhat-release")[/(\d+)/, 0]
        Integer(major_version_string, 10)
      end
    end
  end
end
