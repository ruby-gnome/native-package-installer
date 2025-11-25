# Copyright (C) 2017-2025  Ruby-GNOME Project Team
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

require "rubygems-requirements-system/installer"

# Other files exist only for backward compatibility.
require_relative "native-package-installer/version"

require_relative "native-package-installer/executable-finder"
require_relative "native-package-installer/os-release"

require_relative "native-package-installer/platform"

class NativePackageInstaller
  class << self
    def install(spec)
      new(spec).install
    end
  end

  def initialize(spec)
    @spec = spec
    ui = RubyGemsRequirementsSystem::UI.new(Gem.ui)
    @platform = RubyGemsRequirementsSystem::Platform.detect(ui)
  end

  def install
    spec = @spec.dup
    if @platform.target?("fedora")
      spec[:fedora] ||= spec[:rhel] || spec[:redhat]
    elsif @platform.target?("amazon_linux_2023")
      spec[:amazon_linux_2023] ||=
        spec[:amazon_linux] || spec[:fedora] || spec[:rhel] || spec[:redhat]
    end
    spec.each do |platform_id, system_packages|
      next unless @platform.target?(platform_id.to_s)
      system_packages = [system_packages] unless system_packages.is_a?(Array)
      requirement =
        RubyGemsRequirementsSystem::Requirement.new([], system_packages)
      @platform.install(requirement)
    end
  end
end
