#!/bin/sh

sbcl --load build-linux-ncurses.lisp
sbcl --load build-linux-sdl2.lisp
cp -r linux /tmp/lem-v2.1.0
cd /tmp/
tar -zcf lem-ubuntu-x86-64-v2.1.0.tar.gz lem-v2.1.0
