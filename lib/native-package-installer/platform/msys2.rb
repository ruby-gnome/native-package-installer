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
    class MSYS2
      Platform.register(self)

      class << self
        def current_platform?
          return false if package_prefix.nil?
          not pacman_path.nil?
        end

        def pacman_path
          finder = ExecutableFinder.new("pacman")
          case RUBY_PLATFORM
          when "i386-mingw32"
            Dir.glob("c:/msys{64,32,*}/usr/bin") do |bin|
              finder.append_path(bin)
            end
          when "x64-mingw32"
            Dir.glob("c:/msys{64,*}/usr/bin") do |bin|
              finder.append_path(bin)
            end
          end
          finder.find
        end

        def package_prefix
          case RUBY_PLATFORM
          when "i386-mingw32"
            "mingw-w64-i686-"
          when "x64-mingw32"
            "mingw-w64-x86_64-"
          else
            nil
          end
        end
      end

      def package(spec)
        base_name = spec[:msys2]
        return nil if base_name.nil?

        "#{self.class.package_prefix}#{base_name}"
      end

      def install_command
        pacman_dir, pacman = File.split(self.class.pacman_path)
        ENV["PATH"] = [pacman_dir, ENV["PATH"]].join(File::PATH_SEPARATOR)
        "#{pacman} -S --noconfirm"
      end

      def need_super_user_priviledge?
        false
      end
    end
  end
end
