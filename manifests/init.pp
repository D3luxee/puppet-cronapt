#
#Class cronapt
#
# installs and configures cronapt
#
# Parameters:
#
# [*package_ensure*]
#   Passed to the cron-apt package.
#   Defaults to 'installed'
#
# [*packages*]
#   cron-apt package name.
#   Defaults to 'cron-apt'
#

# [*cron_mail*]
#   Defines the email address to send mail to.
#   Defaults to 'root'
#
# [*cron_mail_on*]
#   When to send email about the cron-apt results.
#   Defaults to 'error'
#
# [*cron_syslog_on*]
#   When to log the cron-apt results to syslog.
#   Defaults to 'upgrade'
#
# [*cron_debug*]
#   When to log to the cron-apt log file.
#   Defaults to 'output'
#
# [*cron_actiondir*]
#   The directory where configuration per action is stored.
#   Defaults to '/etc/cron-apt/action.d'
#
# [*cron_actionconfdir*]
#   The directory where configuration per action is stored.
#   Defaults to '/etc/cron-apt/config.d'
#
# [*cron_mailmsgdir*]
#   The directory where messages that will be prepended to the email that is
#   sent (per action) is stored.
#   Defaults to '/etc/cron-apt/mailmsg.d'
#
# [*cron_syslogmsgdir*]
#   The directory where messages that will be prepended to text that is
#   sent (per action) to syslog.
#   Defaults to '/etc/cron-apt/syslogmsg.d'
#
# [*cron_errormsgdir*]
#   The directory where messages that will be prepended to the error message
#   (per action) is stored.
#   Defaults to '/etc/cron-apt/errormsg.d'
#
# [*cron_logmsgdir*]
#   The directory where messages that will be prepended to the log (debug)
#   message (per action) is stored.
#   Defaults to '/etc/cron-apt/logmsg.d'
#
# [*cron_mailonmsgdir*]
#   The directory where messages that will be prepended to the mail message
#   (per MAILON type) is stored.
#   Defaults to '/etc/cron-apt/mailonmsgs'
#
# [*cron_syslogonmsgdir*]
#   The directory where messages that will be prepended to the syslog message
#   (per SYSLOGON type) is stored.
#   Defaults to '/etc/cron-apt/syslogonmsgs'
# [*purgedir*]
#   Global purge config dir variable
#   Defaults to true
class cronapt (
    #cron-apt::install parameters:
    $package_ensure = $cronapt::params::package_ensure,
    $packages = $cronapt::params::packages,
    #cron-apt parameters:
    $cron_aptcommand = $cronapt::params::cron_aptcommand,
    $cron_mail    = $cronapt::params::cron_mail,
    $cron_mail_on = $cronapt::params::cron_mail_on,
    $cron_syslog_on = $cronapt::params::cron_syslog_on,
    $cron_debug = $cronapt::params::cron_debug,
    $cron_actiondir = $cronapt::params::cron_actiondir,
    $cron_actionconfdir = $cronapt::params::cron_actionconfdir,
    $cron_mailmsgdir = $cronapt::params::cron_mailmsgdir,
    $cron_syslogmsgdir = $cronapt::params::cron_syslogmsgdir,
    $cron_errormsgdir = $cronapt::params::cron_errormsgdir,
    $cron_logmsgdir = $cronapt::params::cron_logmsgdir,
    $cron_mailonmsgdir = $cronapt::params::cron_mailonmsgdir,
    $cron_syslogonmsgdir = $cronapt::params::cron_syslogonmsgdir,
    $purgedir = $cronapt::params::purgedir,
    ) inherits cronapt::params {

    contain '::cronapt::install'
    contain '::cronapt::configure'

    Class['cronapt::install'] -> Class['cronapt::configure']
}
