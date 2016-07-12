#!/bin/bash

# Install package 'expect' if not exist.
# Only Linux systems with apt-get or yum works.

command_exists() {
	command -v "$@" > /dev/null 2>&1 
}

install_by_yum() {
	echo "run yum install -y expect"
	yum install -y expect
}

install_by_apt_get() {
	echo "run apt-get install -y expect"
	apt-get install -y expect
}

main() {
	if command_exists expect; then
		echo "expect already exists, skip installation"
		return 0
	fi
	if command_exists apt-get; then
		install_by_apt_get
	fi
	if command_exists yum; then
		install_by_yum
	fi
}

main "$@"
