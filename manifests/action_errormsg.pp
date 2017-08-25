# == Cdefine cronapt::action_errormsg
#
define cronapt::action_errormsg(
  $priority = undef,
  $content = undef,
  ) {
    if $content {
      file { "${::cronapt::cron_errormsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $content,
      }
    }
  }
