package Image::Glitch;
use strict;
use warnings;
use File::Type;
use File::Slurp;
use Carp;
use UNIVERSAL::require;
our $VERSION = '0.01';

my $supported_formats = {
    'image/x-png' => 'Image::Glitch::PNG',
    'image/jpeg'  => 'Image::Glitch::JPEG',
};

sub new{
    my $class = shift;
    bless {},$class;
}

sub glitch_file{
    my ($self, $path) = @_;
    my $data = read_file($path);
    return $self->glitch($data);
}

sub glitch{
    my ($self, $data) = @_;

    my $file_type = $self->_detect_format($data);
    croak "unsupported file type: $file_type." unless $supported_formats->{$file_type};

    my $glitcher = $supported_formats->{$file_type};
    $glitcher->require;
    return $glitcher->glitch($data);
}

sub _detect_format{
    my ($self, $data) = @_;

    my $ft = File::Type->new();
    return $ft->checktype_contents($data);
}

1;
__END__

=head1 NAME

Image::Glitch -

=head1 SYNOPSIS

  use Image::Glitch;

=head1 DESCRIPTION

Image::Glitch is

=head1 AUTHOR

Shinpei Maruyama E<lt>shinpeim {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
