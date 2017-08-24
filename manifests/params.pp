#
class cronapt::params {

    $package_ensure = 'installed'
    $packages = ['cron-apt']

    $cron_aptcommand = '/usr/bin/apt-get'
    # The email address to send mail to.
    $cron_mail = 'root'

    # When to send email about the cron-apt results.
    # Value: error   (send mail on error runs)
    #        upgrade (when packages are upgraded)
    #        changes (mail when change in output from an action)
    #        output  (send mail when output is generated)
    #        always  (always send mail)
    #                (else never send mail)
    $cron_mail_on = 'error'



    #When to log the cron-apt results to syslog.
    #  Value:
    #    error   (syslog on error runs)
    #    upgrade (when packages is upgraded)
    #    changes (syslog when change in output from an action)
    #    output  (syslog when output is generated)
    #    always  (always syslog)
    #    never   (never syslog)
    #            (else never syslog)
    $cron_syslog_on = 'upgrade'


    #When to log to the cron-apt log file.
    #Value:
    #  verbose (log everything)
    #  always  (always log)
    #  upgrade (when packages is upgraded)
    #  changes (log when change in output from an action)
    #  output  (log when output is generated)
    #  error   (log error runs only)
    #  never   (log nothing)
    #          (else log nothing)
    $cron_debug = 'output'

    #The directory where the actions is stored.

    $cron_actiondir = '/etc/cron-apt/action.d'

    # The directory where configuration per action is stored. The message file
    # must have the same name as the action file.
    $cron_actionconfdir = '/etc/cron-apt/config.d'

    # The directory where messages that will be prepended to the email that is
    # sent (per action) is stored. The message file must have the same name as
    # the action file.
    $cron_mailmsgdir = '/etc/cron-apt/mailmsg.d'

    # The directory where messages that will be prepended to text that is
    # sent (per action) to syslog. The message file must have the same name as
    # the action file.
    $cron_syslogmsgdir = '/etc/cron-apt/syslogmsg.d'

    # The directory where messages that will be prepended to the error message
    # (per action) is stored. The message file must have the same name as
    # the action file.
    $cron_errormsgdir = '/etc/cron-apt/errormsg.d'

    # The directory where messages that will be prepended to the log (debug)
    # message (per action) is stored. The message file must have the same name as
    # the action file.
    $cron_logmsgdir = '/etc/cron-apt/logmsg.d'

    # The directory where messages that will be prepended to the mail message
    # (per MAILON type) is stored. The message file must have the same name as
    # the MAILON directive.
    $cron_mailonmsgdir = '/etc/cron-apt/mailonmsgs'

    # The directory where messages that will be prepended to the syslog message
    # (per SYSLOGON type) is stored. The message file must have the same name as
    # the SYSLOGON directive.
    $cron_syslogonmsgdir = '/etc/cron-apt/syslogonmsgs'

    $purgedir = true
}
