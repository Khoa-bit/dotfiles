#! /usr/bin/bash

# Start ibus as a background job
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

ibus start &
