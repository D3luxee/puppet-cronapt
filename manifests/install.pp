#
# Class: cronapt::install
#
class cronapt::install {

    # Install
    package { $::cronapt::packages :
        ensure => $::cronapt::package_ensure
    }
}
