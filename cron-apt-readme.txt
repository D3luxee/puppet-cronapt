cron-apt for Debian
-------------------

The intention of cron-apt is to automate the process to upgrade the Debian
GNU/Linux operating system. By default it only download packages which means
that the actual installation/upgrade must be done manually. It is possible
to fully update the upgrade procedure if you want but be aware that this
may break the installation in case something goes wrong.



General Configuration:
----------------------

All cron-apt configuration is placed in /etc/cron-apt. The structure of that
directory is as follows.

  Main configuration:
    - config
    - action.d/
    - config.d/
  Additional configuration for logging:
    - *msg.d/
    - *msgs/

The general principle of cron-apt configuration is that actions are defined in
/etc/cron-apt/action.d/. Each action file can contain one or more lines to
execute. Each line in an action file is passed as an argument to apt-get
(or more precisely the command defined by the APTCOMMAND and OPTIONS
configuration variables). The actions are executed in alphabetical order and
line by line. Use a number from zero (0) to nine (9) to give a precise order.

The default actions are:
 * 0-update:   Updates the list of known packages
 * 3-download: Downloads the updated packages but do not install them

The file /etc/cron-apt/config holds the main configuration data.

It is also possible to add extra configuration for each action (same syntax as
/etc/cron-apt/config) by naming the file /etc/cron-apt/config.d/<actionname>.
The configuration from one action is kept to the next action as well.



Configuration file syntax:
--------------------------

The configuration files (/etc/cron-apt/config and
/etc/cron-apt/config.d/<action>) consists of a number of variables that can be
set to values as outlined below. In addition they follow the POSIX /bin/sh
syntax which means that they can be used for hooks and simlar things as well
as simply setting variables. These variables are described below with their
default value.


APTCOMMAND=/usr/bin/apt-get (default)

  The command used to execute all actions. By default apt-get is used and
  this is also the recommended command to use. For more information see
  above. Alternative settings can be:

   APTCOMMAND=/usr/bin/aptitude
   APTCOMMAND=/usr/bin/apt-file


OPTIONS="-o quiet=1"

  General apt options that will be passed to all APTCOMMAND calls.
  Use "-o quiet" instead of "-q" for aptitude compatibility.

  You can for example add an additional sources.list file here.
   OPTIONS="-o quiet=1 --no-list-cleanup -o Dir::Etc::SourceList=/etc/apt/security.sources.list"
  You can also set an alternative sources.list file here.
   OPTIONS="-o quiet=1 --no-list-cleanup -o Dir::Etc::SourceList=/etc/apt/securi ty.sources.list -o Dir::Etc::SourceParts=\"/dev/null\""
  If you want to allow unauthenticated and untrusted packages add the
  following to your options directive.
   OPTIONS="-o quiet=1 -o APT::Get::AllowUnauthenticated=true -o aptitude::Cmdli ne::ignore-trust-violations=yes"
  To limit the bandwidth used use the following line. This example limit the
  bandwidth usage to 25 kB/s.
   OPTIONS="-o Acquire::http::Dl-Limit=25"


MAILON="error"

  When to send email about the cron-apt results.
  Value:
    error   (send mail on error runs)
    upgrade (when packages are upgraded)
    changes (mail when change in output from an action)
    output  (send mail when output is generated)
    always  (always send mail)
    never   (never send mail)
            (else never send mail)


SYSLOGON="upgrade"

  When to log the cron-apt results to syslog.
  Value:
    error   (syslog on error runs)
    upgrade (when packages is upgraded)
    changes (syslog when change in output from an action)
    output  (syslog when output is generated)
    always  (always syslog)
    never   (never syslog)
            (else never syslog)


RUNSLEEP=3600

  The random sleep time in seconds. This is used to prevent clients from
  accessing the APT sources all at the same time and overwhelming them.
  Default is 3600 seconds which means one hour.


DONTRUN=""

  Do not run the command, if there is an error in the previous run (default).
  Value:
    error   (do not run if there is an error on last run)
            (else always run, remove previous error file and run)


MAILTO="root"

  The email address to send mail to.


DEBUG="output"

  When to log to the cron-apt log file.
  Value:
    verbose (log everything)
    always  (always log)
    upgrade (when packages is upgraded)
    changes (log when change in output from an action)
    output  (log when output is generated)
    error   (log error runs only)
    never   (log nothing)
            (else log nothing)


DIFFONCHANGES=prepend

  What to do with the diff when *ON is set to 'changes'.
  Value:
    prepend (prepend to the output)
    append  (append to the output)
    only    (only show the diff, not the output itself)
            (else do nothing)


REFRAINFILE=/etc/cron-apt/refrain

  If this file exist cron-apt will silently exit.


HOSTNAME=""

  If this is non-empty, it will be used as the host name in subjects of
  generated e-mail messages. If this is empty, the output of uname -n
  will be used.


DIFFIGNORE=""

  Ignore lines matching this regexp to determine whether changes occurred
  for MAILON="changes". If empty no lines will be ignored.

  Suggested value for aptitude:
    DIFFIGNORE="^\(Get:[[:digit:]]\+\|Hit\|Ign\|Del\|Fetched\|Freed\|Reading\)[[:space:]]"

  Suggested value for apt-get:
    DIFFIGNORE="^\(Get:[[:digit:]]\+\|Hit\|Ign\)[[:space:]]"


XHEADER*

  Support for mail headers. You can add up to 9 headers to the mail sent.
  This below example can be used for OTRS.
  The default is no headers added.
  XHEADER1="X-OTRS-Queue: updates"
  XHEADER2="X-OTRS-Loop: true"
  ...


APT_CONFIG=/etc/apt/cron.apt.paths

   Additional APT configuration file that is loaded first. This can be set in
   order to use a completely different APT configuration for cron-apt. See the
   /usr/share/doc/cron-apt/README and apt.conf(5) for details

    export APT_CONFIG=/etc/apt/cron.apt.paths


PATH

  A path is needed for cron-apt to work. The default PATH is as written
  below.

    export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin


MINTMPDIRSIZE=10

   The minimum amount of disc space (in kB) that need to exist on the
   device where temporary files are created (mktemp) to allow cron-apt
   to run. If set to 0 it will always continue even if empty.


ACTIONDIR="/etc/cron-apt/action.d"

   The directory where the actions is stored.


ACTIONCONFDIR="/etc/cron-apt/config.d"

  The directory where configuration per action is stored. The message file
  must have the same name as the action file.


MAILMSGDIR="/etc/cron-apt/mailmsg.d"

  The directory where messages that will be prepended to the email that is
  sent (per action) is stored. The message file must have the same name as
  the action file.


SYSLOGMSGDIR="/etc/cron-apt/syslogmsg.d"

  The directory where messages that will be prepended to text that is
  sent (per action) to syslog. The message file must have the same name as
  the action file.


ERRORMSGDIR="/etc/cron-apt/errormsg.d"

  The directory where messages that will be prepended to the error message
  (per action) is stored. The message file must have the same name as
  the action file.


LOGMSGDIR="/etc/cron-apt/logmsg.d"

  The directory where messages that will be prepended to the log (debug)
  message (per action) is stored. The message file must have the same name as
  the action file.


MAILONMSGSDIR="/etc/cron-apt/mailonmsgs"

  The directory where messages that will be prepended to the mail message
  (per MAILON type) is stored. The message file must have the same name as
  the MAILON directive.


SYSLOGONMSGSDIR="/etc/cron-apt/syslogonmsgs"

  The directory where messages that will be prepended to the syslog message
  (per SYSLOGON type) is stored. The message file must have the same name as
  the SYSLOGON directive.


NOLOCKWARN=""

  Whether to warn about the fact that dotlockfile is not installed.
  Value:
    ""       (warn if dotlockfile is not installed)
    "nowarn" (don't give warning if dotlockfile not installed)


ERROR="/var/log/cron-apt/error"

  The temporary file that contains error messages.


TEMP="/var/log/cron-apt/temp"

  The temporary file that contains current run information when still running
  the script.


LOG="/var/log/cron-apt/log"

  The temporary logfile (for debugging). Use syslog for normal logging.


MAIL="/var/log/cron-apt/mail"

  The temporary file that contain information to be sent in email.


EXITON="error"

  Whether to exit on errors or not.
  Value:
    error   (exit on error only)
            (else never exit)


UMASK_APT="022"

  Umask for the files created by the APT command used. In all other cases
  umask 077 will be used.



Alternative APT command:
------------------------

The APTCOMMAND configuration variable defines the APT command to use to execute
the actions. By default /usr/bin/apt-get is used and this is is also the
recommended command to use.

But you can actually use any program you like. Although aptitude is the
recommended tool for interactive upgrades, for cron-apt's purposes apt-get is
better and, for most configurations, the extra features of aptitude are not
relevant. If you insist on using aptitide, you will have to work around some
of its bugs.
OBSERVE that cron-apt is indended to use apt-get and tools like aptitude do not
have full support for noninteractive upgrades. You may have to tune options
to not create infinit logfiles for example.

Setting it to /usr/bin/aptitude (to use aptitude instead of apt-get) will
resolve changed Recommends (and Suggests as well, if aptitude is configured
so).

You can also set other utilities (especially useful for files in the config.d/
directory) to set some completely different tool.



Configuration for logging:
--------------------------

In addition to the main configuration it is possible to define extra
information to be logged at execution. The principle is that files in
<something>msg.d/ is logged for each action and files in <something>msgs/ are
logged for matching configuration directive.

The the below descriptions the following tag syntax is used: [TAG].
The tag means that this configuration is only used in case the TAG
configuration variable tell that logging should be done.

 * /etc/cron-apt/errormsg.d/
   Contains a file for each action to log in case an error occur in the
   corresponding action. This is used in case any of the configuration
   directive tells that logging should be done.
 * /etc/cron-apt/logmsg.d/ [DEBUG]
   Contains a file for each action to log to stdout.
 * /etc/cron-apt/mailmsg.d/ [MAILON]
   Contains a file for each action to prepend to the email sent.
 * /etc/cron-apt/syslogmsg.d/ [SYSLOGON]
   Contain files for each action to log in syslog.
 * /etc/cron-apt/mailonmsgs/ [MAILON]
   Contain files, with name corresponding to the MAILON configuration variable,
   with text to prepend to the email sent.
 * /etc/cron-apt/syslogonmsgs/ [SYSLOGON]
   Contain files, with name corresponding to the SYSLOGON configuration
   variable, with text to log to syslog.

For more details about this see 'Configuration file syntax' below.



Regular execution:
------------------

 If you want this tool to be run even if you do not have it up at
 04 in the morning you can create a symbolic link from /etc/cron.daily/cron-apt
 to /usr/sbin/cron-apt. It will then be run every day (even if the computer is
 not on at that time). Similar things can be done for each week, and so on.
 You have to have anacron installed for this to work. If not, daily scripts
 run 6 AM by crond.

  ln -s /usr/sbin/cron-apt /etc/cron.daily/cron-apt

 Observe that it is not always a good thing to update package information
 and download files when the computer is started. This is especially true
 if you do not have a good Internet connection.

 You also need to disable the normal cron.d/cron-apt file if you do not want
 it to be run twice.



Alternate sources.list file
---------------------------

If you just want to update security related things you can always use an
alternate sources.list files by giving this extra information to the OPTIONS
variable in the configuration file.

 OPTIONS="-o quiet=1 --no-list-cleanup -o Dir::Etc::SourceList=/etc/apt/security.sources.list -o Dir::Etc::SourceParts=\"/dev/null\""

Alternatively you can use a separate APT configuration file as described
in the chapter below. You can for example point to a source list as follows:

 Dir::Etc::SourceList "/etc/apt/security.sources.list";
 Dir::Etc::SourceParts "/dev/null"

In that case you only need to update the OPTIONS variable to include the
'--no-list-cleanup' argument.



Alternate APT main configuration
--------------------------------

There are cases when you need the APT configuration for use with cron-apt to
differ substantially from your standard configuration. For example, cron-apt
will not work with the default configuration of APT, when apt-listbugs is
installed, because this adds a hook that expects keyboard interactivity.

Unfortunately, the apt-tools do not accept Dir::Etc::Main and Dir::Etc::Parts
settings on the command-line. In order to use different paths for them, you
have to create another APT configuration file containing eg:

 Dir::Etc::Main "cron.apt.conf";
 Dir::Etc::Parts "cron.apt.conf.d";

Then uncomment the following line in your cron-apt configuration file and
point it to your newly created APT configuration file:

 export APT_CONFIG=/etc/apt/cron.apt.paths

Don't forget additional options you might have set in /etc/apt/apt.conf since
this file is no longer use when APT_CONFIG point to another conf file.



Development and documentation
-----------------------------

If you want more information about this software you can visit the homepage
at http://inguza.com/software/cron-apt/. You can find documentation,
development information and other things there.



Copyright information:
----------------------

 Copyright (C) 2002-2011,2013 Ola Lundqvist <ola@inguza.com>
 Copyright (C) 2009           Edward Malone <edward.malone88@gmail.com>
 Copyright (C) 2004-2011,2013 Marc Haber <mh+debian-bugs@zugschlus.de>
 Copyright (C) 2004,2007,2013 Bob Proulx <bob@proulx.com>
 Copyright (C) 2006           Felix Palmen <fmp@palmen.homeip.net>
 Copyright (C) 2004           Marc Sherman <msherman@projectile.ca>
 Copyright (C) 2004           David Weinehall
 Copyright (C) 2003           Sean Finney <seanius@seanius.net>
 Copyright (C) 2002           Marcel Kolaja <marcel@solnet.cz>



License terms
-------------

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program as the file COPYING; if not, write to the
 Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 MA 02110-1301 USA.