# Copyright (C) 2022-2023  Ruby-GNOME Project Team
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

require_relative "red-hat-enterprise-linux"

class NativePackageInstaller
  module Platform
    class AmazonLinux2 < RedHatEnterpriseLinux
      Platform.register(self)

      class << self
        def current_platform?
          os_release = OSRelease.new
          os_release.id == "amzn" and os_release.version == "2"
        end
      end

      def package(spec)
        spec[:amazon_linux_2] || spec[:amazon_linux] || super
      end

      def install_command
        "yum install -y"
      end
    end
  end
end
