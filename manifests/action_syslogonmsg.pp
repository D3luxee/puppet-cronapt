# == Cdefine cronapt::action_syslogonmsg
#
define cronapt::action_syslogonmsg(
  $priority = undef,
  $syslogonmsgstr = undef,
  ) {
    if $syslogonmsgstr {
      file { "${::cronapt::cron_syslogonmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $syslogonmsgstr,
      }
    }
  }
