#!/bin/bash
set -x

cd $HOME

RESULTDIR=$HOME/scale-validation-result


if [ -d "$HOME/scale-validation/.git" ]; then
    echo "Scale validation already exists"
else
    set -e
    git clone https://github.com/spectral-compute/scale-validation.git $HOME/scale-validation
    set +e
fi



rm -rf ${RESULTDIR}
mkdir ${RESULTDIR}

cd $HOME/scale-validation

for i in $(find * -depth -maxdepth 1 -type d)  ; do
 echo "Running $i $> ${RESULTDIR}/${i}.log";

rm -rf /tmp/${i}
mkdir -p ${i}

time ./test.sh /tmp/${i} $HOME/scale/SCALE gfx1100 ${i} &> ${RESULTDIR}/${i}.log


done
