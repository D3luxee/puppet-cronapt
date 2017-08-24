#
#Class cronapt
#
# installs and configures cronapt
#
# Parameters:
#
# [*ensure*]
#   Passed to the cron-apt package.
#   Defaults to 'installed'
#
# [*packages*]
#   cron-apt package name.
#   Defaults to 'cron-apt'
#
# [*cron_actions*]
#   Defines some predefined default actions.
#   Defaults to ['update', 'download']
#   Can be set to undef to remove all default configurations
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
# [*actiondir*]
#   The directory where configuration per action is stored.
#   Defaults to '/etc/cron-apt/action.d'
#
# [*actionconfdir*]
#   The directory where configuration per action is stored.
#   Defaults to '/etc/cron-apt/config.d'
#
# [*mailmsgdir*]
#   The directory where messages that will be prepended to the email that is
#   sent (per action) is stored.
#   Defaults to '/etc/cron-apt/mailmsg.d'
#
# [*syslogmsgdir*]
#   The directory where messages that will be prepended to text that is
#   sent (per action) to syslog.
#   Defaults to '/etc/cron-apt/syslogmsg.d'
#
# [*errormsgdir*]
#   The directory where messages that will be prepended to the error message
#   (per action) is stored.
#   Defaults to '/etc/cron-apt/errormsg.d'
#
# [*logmsgdir*]
#   The directory where messages that will be prepended to the log (debug)
#   message (per action) is stored.
#   Defaults to '/etc/cron-apt/logmsg.d'
#
# [*mailonmsgdir*]
#   The directory where messages that will be prepended to the mail message
#   (per MAILON type) is stored.
#   Defaults to '/etc/cron-apt/mailonmsgs'
#
# [*syslogonmsgdir*]
#   The directory where messages that will be prepended to the syslog message
#   (per SYSLOGON type) is stored.
#   Defaults to '/etc/cron-apt/syslogonmsgs'
# [*purgeDir*]
#   Global purge config dir variable
#   Defaults to true
class cronapt (
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
    ) inherits cronapt::params {

    contain '::cronapt::install'
    contain '::cronapt::configure'

    Class['cronapt::install'] -> Class['cronapt::configure']
}
