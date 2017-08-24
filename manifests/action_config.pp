# == Define: action_config
#
define action_config (
  $priority = undef,
  $configstr = undef,
  ) {
    if $configstr {
      file { "${::cronapt::actionconfdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $configstr,
      }
    }
}
