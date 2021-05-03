#!/bin/sh

wmctrl -l | cut -d' ' -f 1 | xargs -n1 wmctrl -i -a