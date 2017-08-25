# == Cdefine cronapt::action_mailonmsg
#
define cronapt::action_mailonmsg(
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_mailonmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
  }
