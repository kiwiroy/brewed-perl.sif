Bootstrap: shub
From: kiwiroy/perlbrew-base

%labels
    Author kiwiroy@users-noreply.github.com
    Maintainer kiwiroy@users-noreply.github.com
    Version 1.00

%post -c /bin/bash
    source $SINGULARITY_ENVIRONMENT
    perlbrew install-patchperl --yes
    perlbrew install perl-5.28.1 || tail -n101 $PERLBREW_ROOT/build.perl-5.28.1.log
    env
    exit 1
