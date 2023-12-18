# News

## 1.1.9 - 2023-12-18

### Improvements

  * Added support for Alpine Linux.

## 1.1.8 - 2023-06-21

### Improvements

  * conda: Stopped to use conda unless `CONDA_PREFIX` environment
    variable is defined.

## 1.1.7 - 2023-06-20

### Fixes

  * conda: Fixed a bug that auto installation may be blocked.

## 1.1.6 - 2023-06-18

### Improvements

  * Added support for conda.

  * Added support for Amazon Linux 2023.

## 1.1.5 - 2022-07-24

### Improvements

  * Added support for Red Hat Enterprise Linux 9.

  * Added support for Gentoo Linux.

## 1.1.4 - 2022-03-17

### Improvements

  * Added support for Amazon Linux.
    [GitHub#14][Reported by docusend1]

  * Renamed the key for Red Hat Enterprise Linux based system such as
    AlmaLinux and CentOS to `:rhel` from `:redhat`. `:redhat` still
    can be used to keep backward compatibility.

### Thanks

  * docusend1

## 1.1.3 - 2022-01-18

### Fixes

  * Fixed wrong package install on Windows.

## 1.1.2 - 2022-01-18

### Improvements

  * Changed priority for Homebrew on Linux. System package manager is preferred.

  * Improved OpenSuSE detection.

  * Added support for Ruby 3.1 based RubyInstaller.

## 1.1.1 - 2021-01-17

### Improvements

  * [CentOS 8] Followed the powertools repository name change.

## 1.1.0 - 2020-04-12

### Improvements

  * Updated README.
    [GitHub#11][Patch by kojix2]

  * Added support for Raspbian.
    [GitHub#12][Patch by xetum]

### Thanks

  * kojix2

  * xetum

## 1.0.9 - 2019-12-10

### Improvements

  * Added support for Ubuntu specific package.
    [GitHub#9][Patch by İsmail Arılık]

### Thanks

  * İsmail Arılık

## 1.0.8 - 2019-10-10

### Improvements

  * Enabled PowerTools repository on CentOS 8.

## 1.0.7 - 2019-03-09

### Fixes

  * Fixed 32bit MSYS2 detection.

## 1.0.6 - 2017-12-05

### Improvements

  * Added meta character support in package name.
    [GitHub#8][Reported by Mamoru TASAKA]

### Fixes

  * Removed needless ArchLinux fallback from PLD Linux.
    [GitHub#7][Reported by Elan Ruusamäe]

### Thanks

  * Elan Ruusamäe

  * Mamoru TASAKA

## 1.0.5 - 2017-11-11

### Improvements

  * Removed needless Packnga development dependency.
    [GitHub#4][Patch by HIGUCHI Daisuke]

  * Added PLD Linux support.
    [GitHub#6][Patch by Elan Ruusamäe]

### Fixes

  * Fixed a bug that `:redhat` package isn't used for Fedora platform.
    [GitHub#5][Patch by HIGUCHI Daisuke]

### Thanks

  * HIGUCHI Daisuke

  * Elan Ruusamäe

## 1.0.4 - 2017-06-04

### Fixes

  * Fixed MSYS2 detection.

## 1.0.3 - 2017-05-29

### Improvements

  * Supported PATH setup on MSYS2.

## 1.0.2 - 2017-05-29

### Improvements

  * Supported DNF on Fedora.
    [GitHub#3][Reported by Vít Ondruch]

  * Supported MSYS2.

### Fixes

  * Fixed broken messages.

### Thanks

  * Vít Ondruch

## 1.0.1 - 2017-05-03

### Improvements

  * Supported FreeBSD.
    [GitHub#1][Patch by Po-Chuan Hsieh]

### Fixes

  * Fixed a bug that an error is raised on unknown platforms.
    [GitHub#2][Patch by Kunihiko Ito]

### Thanks

  * Po-Chuan Hsieh

  * Kunihiko Ito

## 1.0.0 - 2017-04-10

Initial release!!!
