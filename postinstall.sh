bindir=/usr/bin
prog=wx-config
wrapper=/usr/lib/wx/config/wx-wrapper.sh

cd ${bindir}

rm -f ${prog}
ln -sfn ${wrapper} ${prog}
