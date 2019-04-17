Bootstrap: shub
From: kiwiroy/perlbrew-base

%labels
    Author kiwiroy@users-noreply.github.com
    Maintainer kiwiroy@users-noreply.github.com
    Version 1.00

%post -c /bin/bash
    source $SINGULARITY_ENVIRONMENT
    export PERLBREW_PERL=perl-5.28.1
    perlbrew install-patchperl --yes
    perlbrew --force install ${PERLBREW_PERL}
    perlbrew use ${PERLBREW_PERL}
    env
    perlbrew env ${PERLBREW_PERL}
    exit 1
