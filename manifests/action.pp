# == Cdefine cronapt::action
#
define cronapt::action(
  $priority = undef,
  $actionstr = undef,
  ) {
    if $actionstr {
      file { "${::cronapt::cron_actiondir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $actionstr,
      }
    }
  }
