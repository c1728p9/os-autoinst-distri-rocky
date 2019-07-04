use base "installedtest";
use strict;
use testapi;
use utils;

sub run {
    # create a mount point for the ISO
    assert_script_run "mkdir -p /mnt/iso";
    # mount the ISO there
    assert_script_run "mount /dev/cdrom /mnt/iso";
    # download the check script
    assert_script_run "curl -o /usr/local/bin/potential_conflict.py https://pagure.io/fedora-qa/qa-misc/raw/master/f/potential_conflict.py";
    # install python2 and yum - script needs these for now:
    # https://pagure.io/fedora-qa/qa-misc/issue/4
    script_run "dnf -y install yum python2", 180;
    # run the check
    assert_script_run "python2 /usr/local/bin/potential_conflict.py --repofrompath=media,/mnt/iso -r media";
}

sub test_flags {
    return { fatal => 1 };
}

1;

# vim: set sw=4 et: