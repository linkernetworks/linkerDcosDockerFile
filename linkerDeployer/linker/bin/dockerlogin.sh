#!/usr/bin/expect

# Login to docker registry automatically
# Usage:
#   $./dockerlogin.sh domainname:port username password

set reg [lindex $argv 0]
set user [lindex $argv 1]
set pwd [lindex $argv 2]

spawn docker login $reg
expect ":"
send $user\r
expect "Password:"
send $pwd\r
expect "Login Succeeded"
