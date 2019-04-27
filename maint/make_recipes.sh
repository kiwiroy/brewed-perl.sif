#!/usr/bin/env bash

root=$(git rev-parse --show-toplevel)
maint=$(cd $(dirname $0); pwd)

cd $root

echo "Retrieving list of available release perls ..." >&2
perls=($(PERLBREW_ROOT=/tmp perlbrew available | grep ' perl-5\.[123][02468]'))
total=${#perls[*]}

from=kiwiroy/singularity-perlbrew
echo "Common template arguments: -from $from" >&2
echo "Expanding template for latest version (${perls[0]}) ..." >&2
$maint/expand.pl -perl ${perls[0]} -from $from -latest

echo "Expanding template for remaining version of perl ..." >&2
for (( i=0; i<=$(( $total -1 )); i++ ));
do
  $maint/expand.pl -perl ${perls[$i]} -from $from
done

echo "Done" >&2
