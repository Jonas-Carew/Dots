#!/bin/sh

# Creating pre-lock status

#[[ $(nmcli radio wifi) = "enabled" ]] && STAT_WIFI="on" || STAT_WIFI="off"

# Locking

fish -c dark
#loginctl suspend
swaylock

# Post unlock
#nmcli radio wifi $STAT_WIFI

