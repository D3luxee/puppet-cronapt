# == Define: action_mailmsg
#
define action_mailmsg (
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_mailmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
}
