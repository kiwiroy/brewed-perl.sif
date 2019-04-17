Bootstrap: shub
From: kiwiroy/perlbrew-base

%labels
    Author kiwiroy@users-noreply.github.com
    Maintainer kiwiroy@users-noreply.github.com
    Version 1.00

%post -c /bin/bash
    source $SINGULARITY_ENVIRONMENT
    source ${PERLBREW_ROOT}/etc/bashrc
    export PERLBREW_PERL=perl-5.28.1
    # > ${PERLBREW_ROOT}/build.${PERLBREW_PERL}.log
    perlbrew --notest --verbose install ${PERLBREW_PERL} > /dev/null
    perlbrew use ${PERLBREW_PERL}
    env
    perlbrew env ${PERLBREW_PERL}
    echo 'export PATH="${PERLBREW_PATH}:${PATH}"' >> $SINGULARITY_ENVIRONMENT
    exit 1

%test
    true
