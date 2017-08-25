# == Cdefine cronapt::action
#
define cronapt::action(
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_actiondir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
  }
