# Copyright (C) 2013-2017  Ruby-GNOME Project Team
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

require "rbconfig"

class NativePackageInstaller
  class ExecutableFinder
    class << self
      def find(basename)
        new(basename).find
      end

      def exist?(basename)
        new(basename).exist?
      end
    end

    def initialize(basename)
      @basename = basename
      @appended_paths = []
    end

    def find
      extensions = detect_extensions
      paths.each do |path|
        executable_file = File.join(path, @basename)
        return executable_file if executable?(executable_file)
        extensions.each do |extension|
          executable_file_with_extension = executable_file + extension
          if executable?(executable_file_with_extension)
            return executable_file_with_extension
          end
        end
      end
      nil
    end

    def exist?
      not find.nil?
    end

    def append_path(path)
      @appended_paths << path
    end

    private
    def paths
      path_env = ENV["PATH"]
      if path_env
        base_paths = path_env.split(File::PATH_SEPARATOR)
      else
        base_paths = ["/usr/local/bin", "/usr/bin", "/bin"]
      end
      base_paths + @appended_paths
    end

    def detect_extensions
      exts = RbConfig::CONFIG["EXECUTABLE_EXTS"]
      return exts.split if exts
      ext = RbConfig::CONFIG["EXEEXT"]
      return [ext] if ext
      []
    end

    def executable?(path)
      begin
        stat = File.stat(path)
      rescue SystemCallError
        false
      else
        stat.file? and stat.executable?
      end
    end
  end
end
