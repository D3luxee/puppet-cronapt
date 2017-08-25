# == Cdefine cronapt::action_logmsg
#
define cronapt::action_logmsg(
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_logmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
  }
