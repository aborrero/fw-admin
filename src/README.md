src dir
=======

This dir contains all source code of `fw-admin`

Includes: main binary, libs of functions, conffiles and man pages.


To build the project, run:

	$ make

This will generate a tar.gz package with the code ordered (each file in the directory it should be in a standar Linux system) and ready to be installed.

To install the project, run:

	# make install

This will install libs, binarys, config files, and all other stuff in your system.

In the other hand, if you are using a Debian system, it's recommended to build a debian binary package (.deb) and install it.
I would prefer doing this Debian package better than `# make install`, because of the deinstall proccess, which make can't handle.

See the dir `debian` for more info on this.
