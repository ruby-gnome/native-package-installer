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

FROM gentoo/portage as portage

FROM gentoo/stage3

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN \
  echo "MAKEOPTS=\"-j$(($(nproc) +1))\"" >> /etc/portage/make.conf

RUN \
  emerge \
    --getbinpkg \
    --usepkg \
    app-admin/sudo \
    dev-lang/ruby

RUN \
  useradd --user-group --create-home native-package-installer

RUN \
  echo "native-package-installer ALL=(ALL:ALL) NOPASSWD:ALL" | \
    EDITOR=tee visudo -f /etc/sudoers.d/native-package-installer

USER native-package-installer
WORKDIR /home/native-package-installer
