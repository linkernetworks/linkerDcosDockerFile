#!/usr/bin/expect

set pubkey [lindex $argv 0]
set privatekey [lindex $argv 1]
set sshUser [lindex $argv 2]
set publicip [lindex $argv 3]



set timeout 60

spawn ./copy.sh ${pubkey} ${privatekey} ${sshUser} ${publicip}


expect "Are you sure you want to continue connecting (yes/no)?"

send "yes\r"

expect eof
