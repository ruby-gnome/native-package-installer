# Copyright (C) 2023  Ruby-GNOME Project Team
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
    class Conda
      Platform.register(self)

      class << self
        def current_platform?
          ENV["CONDA_PREFIX"] && ExecutableFinder.exist?("conda")
        end
      end

      def package(spec)
        spec[:conda]
      end

      def install_command
        "conda install -c conda-forge -y"
      end

      def need_super_user_priviledge?
        false
      end
    end
  end
end
