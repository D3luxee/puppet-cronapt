# == Define: action_syslogmsg
#
define cronapt::action_syslogmsg (
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_syslogmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
}
