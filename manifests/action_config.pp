# == Define: action_config
#
define cronapt::action_config (
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_actionconfdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
}
