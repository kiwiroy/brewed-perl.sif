#!/usr/bin/env perl
use Mojo::Base -base;
use Applify;
use Mojo::File qw{path};
use Mojo::Loader qw{data_section};
use Mojo::Template;

extends 'Mojo::Base';
documentation __FILE__;
version our $VERSION = '0.01';

option str => author => 'author email for label', (
  default => 'kiwiroy@users-noreply.github.com'
);
option str => from => 'shub container name', (
  required => 1
);
option flag => latest => 'write a Singularity file which will default to latest tag', (
  default => 0
);
option str => perl_version => 'perl version to use', (
  default => '5.10.0'
);
option str => img_version => 'container version', (
  default => '1.00'
);
has app_result => 0;
has outfile  => sub {
  my $self = shift;
  return 'Singularity' if $self->latest;
  return join '.', 'Singularity', $self->perl_version;
};
has template => 'singularity';

sub check_input {
  my $self = shift;
  (my $v = $self->perl_version) =~ s/perl-//;
  $self->perl_version($v);
  return $self;
}

sub expand_to_disk {
  my $self = shift;
  $self->write_file;
  $self;
}

sub render_data {
  my $self = shift;
  my $content = Mojo::Template->new({ vars => 1, line_start => '$-'})
    ->name('Singularity template')
    ->render($self->_applify_data_section($self->template), {
      author => $self->author,
      from   => $self->from,
      maintainer   => $self->author,
      perl_version => $self->perl_version,
      version      => $self->img_version,
    });
  return ref $content ? die $content : $content;
}

sub write_file {
    my $self = shift;
    my $file = path($self->outfile)->spurt($self->render_data);
    return $self;
}

sub _applify_data_section {
  my ($self, $name, $content) = (shift, shift);
  my $klass = ref($self);
  {
    no strict 'refs';
    local *{"${klass}::DATA"};
    open *{"${klass}::DATA"}, '<', __FILE__;
    $content = data_section $klass, $name;
  }
  return $content;
}

app {
  my $self = shift;
  return $self->check_input->expand_to_disk->app_result;
};

__DATA__
@@ singularity
Bootstrap: shub
From: <%= $from %>

%labels
    Author <%= $author %>
    Maintainer <%= $maintainer %>
    Version <%= $version %>

%post -c /bin/bash
    echo '****************************************************'
    echo 'Setup/Display Environment'
    echo '****************************************************'
    source $SINGULARITY_ENVIRONMENT
    source ${PERLBREW_ROOT}/etc/bashrc
    export PERLBREW_PERL=perl-<%= $perl_version %>
    env | grep -i ^perl

    echo '****************************************************'
    echo 'Install perl'
    echo '****************************************************'
    # > ${PERLBREW_ROOT}/build.${PERLBREW_PERL}.log
    perlbrew --notest --verbose install ${PERLBREW_PERL} > /dev/null

    echo '****************************************************'
    echo 'Store Environment'
    echo '****************************************************'
    echo '# Using bash as default shell' >  $SINGULARITY_ENVIRONMENT
    echo "export SHELL=$SHELL"           >> $SINGULARITY_ENVIRONMENT
    echo "export PERLBREW_HOME=$PERLBREW_HOME"    >> $SINGULARITY_ENVIRONMENT
    perlbrew env ${PERLBREW_PERL}                 >> $SINGULARITY_ENVIRONMENT
    echo 'export PATH="${PERLBREW_PATH}:${PATH}"' >> $SINGULARITY_ENVIRONMENT

%runscript
    $*

%test
    if test "${SINGULARITY_CHECKTAGS:-}" = "bootstrap"; then
      . $SINGULARITY_ENVIRONMENT
    fi
    perl -E 'say $^X; say $^V;'
    env | grep -i ^perl
