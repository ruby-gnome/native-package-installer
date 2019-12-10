# Copyright (C) 2013  Ruby-GNOME Project Team
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

require "fileutils"

require "native-package-installer/executable-finder"

class ExecutableFinderTest < Test::Unit::TestCase
  def setup
    @original_path = ENV["PATH"]
    setup_base_dir
    setup_path
  end

  def setup_base_dir
    @base_dir = File.join(File.dirname(__FILE__), "tmp")
    FileUtils.rm_rf(@base_dir)
    FileUtils.mkdir_p(@base_dir)
  end

  def teardown_base_dir
    FileUtils.rm_rf(@base_dir)
  end

  def setup_path
    paths = [
      File.join(@base_dir, "nonexistent"),
      File.join(@base_dir, "bin"),
      File.join(@base_dir, "sbin"),
    ]
    ENV["PATH"] = paths.join(File::PATH_SEPARATOR)
  end

  def teardown
    teardown_base_dir
    ENV["PATH"] = @original_path
  end

  private
  def create_finder(basename)
    NativePackageInstaller::ExecutableFinder.new(basename)
  end

  class TestFind < self
    def test_found
      finder = create_finder("ls")
      ls = File.join(@base_dir, "bin", "ls")
      stub(File).stat(ls) do
        stat = stub(Object.new)
        stat.file? {true}
        stat.executable? {true}
        stat
      end
      stub(File).stat.with_any_args do
        raise Errno::ENOENT
      end
      assert_equal(ls, finder.find)
    end
  end

  class TestExist < self
    def test_true
      finder = create_finder("ls")
      stub(finder).find do
        File.join(@base_dir, "bin", "ls")
      end
      assert_true(finder.exist?)
    end

    def test_false
      finder = create_finder("ls")
      stub(finder).find do
        nil
      end
      assert_false(finder.exist?)
    end
  end
end
