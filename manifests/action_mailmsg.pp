# == Define: action_mailmsg
#
define action_mailmsg (
  $priority = undef,
  $mailmsgstr = undef,
  ) {
    if $mailmsgstr {
      file { "${::cronapt::cron_mailmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $mailmsgstr,
      }
    }
}
