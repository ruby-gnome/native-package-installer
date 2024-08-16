# Copyright (C) 2021  Ruby-GNOME Project Team
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

FROM alt

RUN \
  apt-get update && \
  apt-get install -y \
    gcc \
    gem-rake \
    libruby-devel \
    libpcre-devel \
    make \
    ruby \
    sudo \
    which

RUN \
  useradd --user-group --groups wheel --create-home native-package-installer

RUN \
  echo "native-package-installer ALL=(ALL:ALL) NOPASSWD:ALL" | \
    EDITOR=tee visudo -f /etc/sudoers.d/native-package-installer

USER native-package-installer
WORKDIR /home/native-package-installer
