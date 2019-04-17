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
    perlbrew install-patchperl --yes
    # > ${PERLBREW_ROOT}/build.${PERLBREW_PERL}.log
    perlbrew --notest --verbose install ${PERLBREW_PERL} > /dev/null
    perlbrew use ${PERLBREW_PERL}
    env
    perlbrew env ${PERLBREW_PERL}
    exit 1
