# == Cdefine cronapt::action_syslogonmsg
#
define cronapt::action_syslogonmsg(
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_syslogonmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
  }
