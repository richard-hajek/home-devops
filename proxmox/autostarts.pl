#!/usr/bin/perl

use strict;
use warnings;

print "GUEST HOOK: " . join(' ', @ARGV). "\n";

# Arguments
my $vmid = shift;
my $phase = shift;

if ($phase eq 'pre-start') {

    if ( not -d "/media/CloudPlus/Cloud" ) {
    	print "Expected mounts not found, please fix...\n";
	exit(1);
    }

    if ( not -d "/media/Archive/Archive" ) {
    	print "Expected mounts not found, please fix...\n";
	exit(1);
    }

    if ( $vmid == 101 ){
    	system("grep -q cap.drop /etc/pve/lxc/${vmid}.conf || echo 'lxc.cgroup2.devices.allow: a\nlxc.cgroup.devices.allow: c *:* rwm\nlxc.cgroup.devices.allow: b *:* rwm\nlxc.cap.drop:' >> /etc/pve/lxc/${vmid}.conf")
    }


} elsif ($phase eq 'post-start') {

    # Container autostart script
    my $exit_code = system("lxc-attach", $vmid, "--", "bash" , "-c" ,"[ -f /root/autostart.sh ] && bash /root/autostart.sh");
    print "Autostart script executed with $exit_code \n";

} elsif ($phase eq 'pre-stop') {

} elsif ($phase eq 'post-stop') {

} else {
    die "got unknown phase '$phase'\n";
}

exit(0);
