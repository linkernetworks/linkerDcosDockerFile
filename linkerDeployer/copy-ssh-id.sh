#!/usr/bin/expect

set sshUser [lindex $argv 0]
set publicip [lindex $argv 1]
set key [lindex $argv 2]

set timeout 60

spawn ssh-copy-id -i ${key} ${sshUser}@${publicip}

expect "Are you sure you want to continue connecting (yes/no)?"

send "yes\r"

interact

