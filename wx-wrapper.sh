#!/bin/bash
# Copyright (C) 2006, 2007 Yaakov Selkowitz
# Distributed under the terms of the GNU General Public License v2

# Based on Gentoo Linux's sys-devel/automake-wrapper-1-r1
#
# Executes the correct wx-config version.
#
# - defaults to wx-2.8-config
# - runs wx-2.6-config if:
#   - envvar WANT_WX is set to `2.6'

if [ "${0##*/}" = "wx-wrapper.sh" ] ; then
	echo "Don't call this script directly." >&2
	exit 1
fi

vers="2.8 2.6"

for v in ${vers} ; do
	eval binary_${v/./_}="wx-${v}-config"
done
binary="${binary_2_8}"

#
# Check the WANT_WX setting
#
for v in ${vers} x ; do
	if [ "${v}" = "x" ] ; then
		unset WANT_WX
		break
	fi

	if [ "${WANT_WX}" = "${v}" ] ; then
		binary="binary_${v/./_}"
		binary="${!binary}"
		break
	fi
done

if [ "${WANT_WXWRAPPER_DEBUG}" ] ; then
	if [ "${WANT_WX}" ] ; then
		echo "wx-wrapper: DEBUG: WANT_WX is set to ${WANT_WX}" >&2
	fi
	echo "wx-wrapper: DEBUG: will execute <$binary>" >&2
fi

#
# for further consistency
#
for v in ${vers} ; do
	mybin="binary_${v/./_}"
	if [ "${binary}" = "${!mybin}" ] ; then
		export WANT_WX="${v}"
	fi
done

#
# Now try to run the binary
#
if [ ! -e /usr/bin/"${binary}" ] ; then
	echo "wx-wrapper: $binary is missing or not executable." >&2
	echo "            Please try (re)installing the correct version of wx-devel." >&2
	exit 1
fi

exec "$binary" "$@"

echo "wx-wrapper: was unable to exec $binary !?" >&2
exit 1
