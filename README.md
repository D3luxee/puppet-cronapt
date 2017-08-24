//[![Puppet Forge](http://img.shields.io/puppetforge/v/d3luxee/cronapt.svg)](https://forge.puppetlabs.com/d3luxee/cronapt)

# Puppet Module for cron-apt

This module installs and configures cron-apt. Use it in combination with
a module to manage APT like: [puppetlabs-apt](https://github.com/puppetlabs/puppet-apt)

Available on PuppetForge as ''d3luxee-cronapt'.

## Usage: ##
Install the cron-apt package with its default configuration.
But without the default actions.

    include cronapt

or

    class {'cronapt':
      #cron-apt::install parameters:
      $ensure = $cronapt::params::ensure_install,
      $packages = $cronapt::params::packages,
      #cron-apt parameters:
      $cron_mail    = $cronapt::params::cron_mail,
      $cron_mail_on = $cronapt::params::cron_mail_on,
      $cron_syslog_on = $cronapt::params::cron_syslog_on,
      $cron_debug = $cronapt::params::cron_debug,
      $actiondir = $cronapt::params::actiondir,
      $actionconfdir = $cronapt::params::actionconfdir,
      $mailmsgdir = $cronapt::params::mailmsgdir,
      $syslogmsgdir = $cronapt::params::syslogmsgdir,
      $errormsgdir = $cronapt::params::errormsgdir,
      $logmsgdir = $cronapt::params::logmsgdir,
      $mailonmsgdir = $cronapt::params::mailonmsgdir,
      $syslogonmsgdir = $cronapt::params::syslogonmsgdir,
      $purgedir = $cronapt::params::purgedir,
    }

Add the cron-apt default actions.

Create the 0-update action file
    cronapt::action {'update':
      priority => '0',
      actionstr   => 'update -o quiet=2',
    }

Create the 3-download action file (multiline content example)
    cronapt::action {'download':
      priority => '3',
      actionstr   => inline_template('<%= "autoclean -y" + "\n" + "dist-upgrade -d -y -o APT::Get::Show-Upgraded=true" %>'),
    }




## Options

        actions { update, download, upgrade, notify }
        mail_on { error, upgrade, changes, output, always }
        mail    <a valid email address>

## Parting Words

This example provides full hands-off automatic updates of packages.  Don't be scared.
