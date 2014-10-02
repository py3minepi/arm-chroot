#!/bin/bash

# Based on a test script from avsm/ocaml repo https://github.com/avsm/ocaml

CHROOT_DIR=/tmp/arm-chroot
TARBALL="${CHROOT_DIR}.tar.bz2"
MIRROR=http://archive.raspbian.org/raspbian
VERSION=wheezy
CHROOT_ARCH=armhf

# Debian package dependencies for the host
HOST_DEPENDENCIES="debootstrap qemu-user-static binfmt-support sbuild"

function setup_chroot {
	# Host dependencies
	sudo apt-get install -qq -y ${HOST_DEPENDENCIES}

	# Create chrooted environment
	sudo mkdir ${CHROOT_DIR}
	sudo debootstrap --foreign --no-check-gpg --include=fakeroot,build-essential \
		--arch=${CHROOT_ARCH} ${VERSION} ${CHROOT_DIR} ${MIRROR}
	sudo cp /usr/bin/qemu-arm-static ${CHROOT_DIR}/usr/bin/
	sudo chroot ${CHROOT_DIR} ./debootstrap/debootstrap --second-stage
	sudo sbuild-createchroot --arch=${CHROOT_ARCH} --foreign --setup-only \
		${VERSION} ${CHROOT_DIR} ${MIRROR}
	
	sudo chroot ${CHROOT_DIR} apt-get update

}

function package_chroot {
	tar -cvjf $TARBALL $CHROOT_DIR
}

function test_chroot {
	# TODO
	echo "TODO"
}

setup_chroot
test_chroot
package_chroot
