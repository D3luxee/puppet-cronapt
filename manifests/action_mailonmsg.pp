# == Cdefine cronapt::action_mailonmsg
#
define cronapt::action_mailonmsg(
  $priority = undef,
  $mailonmsgstr = undef,
  ) {
    if $mailonmsgstr {
      file { "${::cronapt::cron_mailonmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $mailonmsgstr,
      }
    }
  }
