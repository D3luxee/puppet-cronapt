# Module: cronapt

[![Puppet Forge](http://img.shields.io/puppetforge/v/d3luxee/cronapt.svg)](https://forge.puppetlabs.com/d3luxee/cronapt)

## Description

This module manages cron-apt. The module handles the installation and provides parameters for the configuration.
It will also provide resource types to manage actions and all related configurations.


Use it in combination with a module to manage APT and Sources like: [puppetlabs-apt](https://github.com/puppetlabs/puppet-apt)

## Compatibility

Latest versions of this module (1.0) are only supported on Puppet >= 3.X

## Usage

In order to install the cron-apt package with its default configuration and its default actions.

```puppet
include cronapt

cronapt::action { 'update':
  priority => '0',
  actionstr   => 'update -o quiet=2',
}

cronapt::action { 'download':
  priority => '3',
  actionstr   => inline_template('<%= "autoclean -y" + "\n" + "dist-upgrade -d -y -o APT::Get::Show-Upgraded=true" %>'),
}
```
or
```puppet
class { 'cronapt': }
```

#### Parameters
Further information about the cron_ parameters can be found within the official [cron-apt readme](https://raw.githubusercontent.com/D3luxee/puppet-cronapt/master/cron-apt-readme.txt)

* `package_ensure`: Default 'installed', can be any supported ensure type for the package resource
* `packages`: Name of the package to install. (default: cron-apt)
* `cron_mail`:  The email address to send mail to, multiple addresses can be seperated by ; (default: root)
* `cron_mail_on`: When to send email about the cron-apt results. (default: error)
* `cron_syslog_on`: When to log the cron-apt results to syslog. (default: upgrade)
* `cron_debug`: When to log to the cron-apt log file. (default: output)
* `cron_actiondir`: The directory where the actions is stored. (default: /etc/cron-apt/action.d)
* `cron_actionconfdir`: The directory where configuration per action is stored. The message file must have the same name as the action file. (default: /etc/cron-apt/config.d)
* `cron_mailmsgdir`: The directory where messages that will be prepended to the email that is sent (per action) is stored. The message file must have the same name as the action file. (default: /etc/cron-apt/mailmsg.d)
* `cron_syslogmsgdir`: The directory where messages that will be prepended to text that is sent (per action) to syslog. The message file must have the same name as the action file. (default: /etc/cron-apt/syslogmsg.d)
* `cron_errormsgdir`: The directory where messages that will be prepended to the error message (per action) is stored. The message file must have the same name as the action file. (default: /etc/cron-apt/errormsg.d)
* `cron_logmsgdir`: The directory where messages that will be prepended to the log (debug) message (per action) is stored. The message file must have the same name as the action file. (default: /etc/cron-apt/logmsg.d)
* `cron_mailonmsgdir`: The directory where messages that will be prepended to the mail message (per MAILON type) is stored. The message file must have the same name as the MAILON directive. (default: /etc/cron-apt/mailonmsgs)
* `cron_syslogonmsgdir`: The directory where messages that will be prepended to the syslog message (per SYSLOGON type) is stored. The message file must have the same name as the SYSLOGON directive. (default: /etc/cron-apt/syslogonmsgs)
* `purgedir`: Gloabal purge variable used by all above specified directory. (default: true)

# Resource Types

The cronapt module contains types and providers to manage actions and all action related configurations. The following types are currently supported.

* [action](#action-example)
* [action_config](#action-example)
* [action_mailmsg](#action-example)
* [action_syslogmsg](#action-example)
* [action_errormsg](#action-example)
* [action_logmsg](#action-example)
* [action_mailonmsg](#action-example)
* [action_syslogonmsg](#action-example)

Note, it is always recommended to include the `cronapt` class if you are going to  use any of these resources from another Puppet class (eg: a profile)  because it sets up the configuration parameters and all resources above rely on those.

## Action example

All action* resource types are structured in the same way, they provide two parameters.
Therefor i will only provide an example to use the _action_ resource in combination with the _action_config_ resource.

_Example in Class_:

```puppet
  cronapt::action { 'security':
    priority         => '5',
    content          => 'upgrade -d -y -o APT::Get::Show-Upgraded=true',
  }

  cronapt::action_config { 'security':
    priority         => '5',
    content          => "OPTIONS=\"-q -o Dir::Etc::SourceList=/etc/apt/sources.list.d/security.list -o Dir::Etc::SourceParts=\\\"/dev/null\\\"\"",
  }
```
This will create the file 5-security within the folder specified with the $cron_actiondir and $cron_actionconfdir variable the files will contain the specified $content.

#### Parameters

* `priority`: Specify file order.
* `content`: Specify the content of the file resource.




# Author

* Written and maintained by Georg Doser <georgdoser@neuland.tech>
