#!/bin/sh
export ASSUME_ALWAYS_YES
ASSUME_ALWAYS_YES=YES

pkg bootstrap
pkg upgrade -y

pkg install -y git python27 tmux vim-tiny
