#
# Class: cronapt::configure
#

class cronapt::configure {
    #
    # Configure
    #
    $mail_on_value = $::cronapt::cron_mail_on ? {
        'error'    => 'error',
        'upgrade'  => 'upgrade',
        'changes'  => 'changes',
        'output'   => 'output',
        'always'   => 'always',
        default    => '',
    }

    $syslog_on_value = $::cronapt::cron_syslog_on ? {
        'verbose'  => 'verbose',
        'always'   => 'always',
        'upgrade'  => 'upgrade',
        'changes'  => 'changes',
        'output'   => 'output',
        'error'    => 'error',
        'never'    => 'never',
        default    => 'upgrade',
    }

    augeas { 'cronapt-mail_config' :
        context => '/files/etc/cron-apt/config',
        changes => [
                      "set APTCOMMAND ${::cronapt::cron_aptcommand}",
                      "set MAILON ${mail_on_value}",
                      "set MAILTO ${::cronapt::cron_mail}",
                      "set SYSLOGON ${syslog_on_value}",
                      "set DEBUG ${::cronapt::cron_debug}",
                      "set ACTIONDIR ${::cronapt::cron_actiondir}",
                      "set ACTIONCONFDIR ${::cronapt::cron_actionconfdir}",
                      "set MAILMSGDIR ${::cronapt::cron_mailmsgdir}",
                      "set SYSLOGMSGDIR ${::cronapt::cron_syslogmsgdir}",
                      "set ERRORMSGDIR ${::cronapt::cron_errormsgdir}",
                      "set LOGMSGDIR ${::cronapt::cron_logmsgdir}",
                      "set MAILONMSGSDIR ${::cronapt::cron_mailonmsgdir}",
                      "set SYSLOGONMSGSDIR ${::cronapt::cron_syslogonmsgdir}",
                      ],
        require => Class['cronapt::install'],
    }

    file { [
      $::cronapt::cron_actiondir,
      $::cronapt::cron_actionconfdir,
      $::cronapt::cron_mailmsgdir,
      $::cronapt::cron_syslogmsgdir,
      $::cronapt::cron_errormsgdir,
      $::cronapt::cron_logmsgdir,
      $::cronapt::cron_mailonmsgdir,
      $::cronapt::cron_syslogonmsgdir,
      ]:
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        recurse => true,
        purge   => $::cronapt::purgedir,
        require => Class['cronapt::install'],
    }

  include cronapt::install
  Class['cronapt::install'] -> Class['cronapt::configure']
}
