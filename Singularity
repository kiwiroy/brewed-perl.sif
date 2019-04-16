Bootstrap: shub
From: kiwiroy/perlbrew-base

%labels
    Author kiwiroy@users-noreply.github.com
    Maintainer kiwiroy@users-noreply.github.com
    Version 1.00

%post -c /bin/bash
    source $SINGULARITY_ENVIRONMENT
    env
    perlbrew available
    exit 1
