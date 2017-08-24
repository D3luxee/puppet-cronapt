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
                      "set MAILON ${mail_on_value}",
                      "set MAILTO ${::cronapt::cron_mail}",
                      "set SYSLOGON ${syslog_on_value}",
                      "set DEBUG ${::cronapt::cron_debug}",
                      "set ACTIONDIR ${::cronapt::actiondir}",
                      "set ACTIONCONFDIR ${::cronapt::actionconfdir}",
                      "set MAILMSGDIR ${::cronapt::mailmsgdir}",
                      "set SYSLOGMSGDIR ${::cronapt::syslogmsgdir}",
                      "set ERRORMSGDIR ${::cronapt::errormsgdir}",
                      "set LOGMSGDIR ${::cronapt::logmsgdir}",
                      "set MAILONMSGSDIR ${::cronapt::mailonmsgdir}",
                      "set SYSLOGONMSGSDIR ${::cronapt::syslogonmsgdir}",
                      ],
        require => Class['cronapt::install'],
    }

    file { [
      $::cronapt::actiondir,
      $::cronapt::actionconfdir,
      $::cronapt::mailmsgdir,
      $::cronapt::syslogmsgdir,
      $::cronapt::errormsgdir,
      $::cronapt::logmsgdir,
      $::cronapt::mailonmsgdir,
      $::cronapt::syslogonmsgdir,
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
