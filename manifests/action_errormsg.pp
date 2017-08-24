# == Cdefine cronapt::action_errormsg
#
define cronapt::action_errormsg(
  $priority = undef,
  $errormsgstr = undef,
  ) {
    if $errormsgstr {
      file { "${::cronapt::errormsgdir}/${priority}-${title}":
        ensure  => file,
        mode    => '0644',
        content => $errormsgstr,
      }
    }
  }
