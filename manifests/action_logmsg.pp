# == Cdefine cronapt::action_logmsg
#
define cronapt::action_logmsg(
  $priority = undef,
  $logmsgstr = undef,
  ) {
    if $logmsgstr {
      file { "${::cronapt::cron_logmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $logmsgstr,
      }
    }
  }
