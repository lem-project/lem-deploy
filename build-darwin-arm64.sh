#!/bin/sh

ROOT_DIR=`pwd`
DEPLOY_DIR=$ROOT_DIR/build
if [ ! -d $DEPLOY_DIR ]; then
    mkdir $DEPLOY_DIR
fi

sbcl --load build-darwin-arm64-sdl2.lisp
sbcl --load build-darwin-arm64-ncurses.lisp

cd darwin/arm64
zip -r lem-sdl2.zip lem.app/
mv lem-sdl2.zip $DEPLOY_DIR/lem-darwin-arm64-sdl2.zip

cd ncurses
zip -r lem-ncurses.zip lem lib/
mv lem-ncurses.zip $DEPLOY_DIR/lem-darwin-arm64-ncurses.zip
