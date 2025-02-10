#!/usr/bin/env bash

# script for niri to disable vrr and turn on secondary monitor if it is off.
niri msg output DP-1 vrr off
niri msg output DP-2 on
