#!/bin/bash
#
# Copyright (C) 2022  Ruby-GNOME Project Team
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

emerge \
  --usepkg \
  app-admin/sudo \
  dev-lang/ruby

mkdir -p /etc/sudoers.d
echo "native-package-installer ALL=(ALL:ALL) NOPASSWD:ALL" | \
  EDITOR=tee visudo -f /etc/sudoers.d/native-package-installer

cd ~native-package-installer
sudo -u native-package-installer -H \
  $(dirname $0)/run-test.sh --no-user-install "$@"
