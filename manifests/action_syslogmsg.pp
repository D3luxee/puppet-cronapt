# == Define: action_syslogmsg
#
define action_syslogmsg (
  $priority = undef,
  $syslogmsgstr = undef,
  ) {
    if $syslogmsgstr {
      file { "${::cronapt::syslogmsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $syslogmsgstr,
      }
    }
}