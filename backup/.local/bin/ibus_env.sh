#!/bin/bash

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

sleep 10;
ibus-daemon -drxR --desktop=kde
