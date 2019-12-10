# Copyright (C) 2017  Ruby-GNOME Project Team
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

require "shellwords"

require "native-package-installer/version"

require "native-package-installer/executable-finder"
require "native-package-installer/platform"

class NativePackageInstaller
  class << self
    def install(spec)
      new(spec).install
    end
  end

  def initialize(spec)
    @spec = spec
    @platform = Platform.detect
  end

  def install
    package = @platform.package(@spec)
    return false if package.nil?

    package_name, *options = package
    package_command_line = [package_name, *options].collect do |component|
      Shellwords.escape(component)
    end.join(" ")

    install_command = "#{@platform.install_command} #{package_command_line}"
    if have_priviledge?
      sudo = nil
    else
      sudo = ExecutableFinder.find("sudo")
    end

    installing_message = "installing '#{package_name}' native package... "
    log_message("%s", installing_message)
    failed_to_get_super_user_priviledge = false
    if have_priviledge?
      succeeded = run_command(install_command)
    else
      if sudo
        prompt = "[sudo] password for %u to install <#{package_name}>: "
        sudo_options = "-p #{Shellwords.escape(prompt)}"
        install_command = "#{sudo} #{sudo_options} #{install_command}"
        succeeded = run_command(install_command)
      else
        succeeded = false
        failed_to_get_super_user_priviledge = true
      end
    end

    if failed_to_get_super_user_priviledge
      result_message = "require super user privilege"
    else
      result_message = succeeded ? "succeeded" : "failed"
    end
    show_postpone_message do
      "#{installing_message}#{result_message}\n"
    end
    log_message("#{result_message}\n")

    error_message = nil
    unless succeeded
      if failed_to_get_super_user_priviledge
        error_message = <<-MESSAGE
'#{package_name}' native package is required.
Run the following command as super user to install required native package:
  \# #{install_command}
        MESSAGE
      else
        error_message = <<-MESSAGE
Failed to run '#{install_command}'.
        MESSAGE
      end
    end
    if error_message
      log_message("%s", error_message)
      show_message("%s", error_message)
    end

    show_message("--------------------\n\n")

    succeeded
  end

  private
  def super_user?
    Process.uid.zero?
  end

  def have_priviledge?
    return true unless @platform.need_super_user_priviledge?
    super_user?
  end

  def with_mkmf?
    Object.const_defined?(:MakeMakefile)
  end

  def run_command(command_line)
    if with_mkmf?
      xsystem(command_line)
    else
      system(command_line)
    end
  end

  def log_message(format, *args)
    if with_mkmf?
      message(format, *args)
    else
      printf(format, *args)
      $stdout.flush
    end
  end

  def show_message(format, *args)
    if with_mkmf?
      MakeMakefile::Logging.message(format, *args)
    else
      printf(format, *args)
      $stdout.flush
    end
  end

  def show_postpone_message(&block)
    if with_mkmf?
      MakeMakefile::Logging.postpone(&block)
    else
      print(yield)
      $stdout.flush
    end
  end
end
