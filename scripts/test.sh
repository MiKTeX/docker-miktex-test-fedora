#!/bin/sh
set -e
rm -fr /miktex/test/logfiles
mkdir /miktex/test/logfiles
export MIKTEX_CORE_USERLOGDIRECTORY=/miktex/test/logfiles
miktexsetup finish
if [ -d /miktex/repository ]; then
    upgrade_options="--repository /miktex/repository"
fi
initexmf --set-config-value=[MPM]AutoInstall=1
miktex packages upgrade ${upgrade_options} basic
cd /miktex/test
export PATH=~/bin:"${PATH}"
cmake /miktex/test-suite
set +e
make test
ec=$?
exit $ec
