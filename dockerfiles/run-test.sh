#!/bin/bash -l
#
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

set -eux

rm -rf native-package-installer.build
cp -r /native-package-installer native-package-installer.build
cd native-package-installer.build

if sudo which rake; then
  sudo rake install
else
  rake install
fi

# Disable rubygems-requirements-system RubyGems plugin and Bundler
# plugin.
export RUBYGEMS_REQUIREMENTS_SYSTEM=false
export GNUMAKEFLAGS="-j$(nproc)"
gem install --user-install cairo "$@"
