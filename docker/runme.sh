#!/bin/sh
set -exuo pipefail
SCRIPT=`readlink -f "$0"`
SCRIPTDIR=`dirname "$SCRIPT"`
PROJECTDIR=`dirname "$SCRIPTDIR"`
docker build -t larcmacs .
docker run -ti -v /usr/local/MATLAB:/usr/local/MATLAB:ro -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \
	--device=/dev/dri -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	--device=/dev/snd --cap-add=ALL	\
	-u `id -u`:`id -g` \
	-v "$PROJECTDIR":"$PROJECTDIR" \
	-w $PROJECTDIR larcmacs $*
