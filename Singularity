Bootstrap: shub
From: kiwiroy/perlbrew-base

%labels
    Author kiwiroy@users-noreply.github.com
    Maintainer kiwiroy@users-noreply.github.com
    Version 1.00

%post -c /bin/bash
    source $SINGULARITY_ENVIRONMENT
    perlbrew install perl-5.28.1
    perlbrew use perl-5.28.1
    perlbrew env perl-5.28.1
    env
    exit 1
