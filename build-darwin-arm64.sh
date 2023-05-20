#!/bin/sh

sbcl --load build-darwin-arm64-sdl2.lisp
sbcl --load build-darwin-arm64-ncurses.lisp

cd darwin/arm64
zip -r lem-sdl2.zip lem.app/

cd ncurses
zip -r lem-ncurses.zip lem lib/
