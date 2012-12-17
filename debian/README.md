debian dir
==========

This folder contains all necessary to build a debian package from `fw-admin` source.

By now, just a debian binary package, and maybe in the future a complete source package.

To build the debian package, run:

	# make

Make sure you have lintian, as the Makefile will call it to check the binary package.

If you want to test `fw-admin` without making a debian package (i.e. you are in rpm-based system)
go to `/src` dir.
