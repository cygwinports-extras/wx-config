bindir=/usr/bin
prog=fox-config
wrapper=/usr/lib/wx/config/ac-wrapper.sh

cd ${bindir}

rm -f ${prog}
ln -sfn ${wrapper} ${prog}
