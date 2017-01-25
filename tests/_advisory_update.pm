use base "installedtest";
use strict;
use testapi;
use utils;

sub run {
    my $self = shift;
    # do the 'repo setup' steps, which set up a repo containing the
    # update packages and run 'dnf update'
    $self->root_console(tty=>3);
    repo_setup;
    # reboot, in case any of the updates need a reboot to apply
    script_run "reboot", 0;
}

sub test_flags {
    # without anything - rollback to 'lastgood' snapshot if failed
    # 'fatal' - whole test suite is in danger if this fails
    # 'milestone' - after this test succeeds, update 'lastgood'
    # 'important' - if this fails, set the overall state to 'fail'
    return { fatal => 1 };
}

1;

# vim: set sw=4 et: