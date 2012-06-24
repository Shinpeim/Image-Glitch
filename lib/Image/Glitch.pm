package Image::Glitch;
use strict;
use warnings;
use File::Type;
use File::Slurp;
use Carp;
use Image::Glitch::GlitchedImage;
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
    my $glitched_data = $glitcher->glitch($data);

    return Image::Glitch::GlitchedImage->new($glitched_data,$file_type);
}

sub _detect_format{
    my ($self, $data) = @_;

    my $ft = File::Type->new();
    return $ft->checktype_contents($data);
}

1;
__END__

=head1 NAME

Image::Glitch - Glitch your image file

=head1 SYNOPSIS

  use Image::Glitch;

  # get glitched image object from binary data
  my $ig = Image::Glitch->new;
  my $glitched = $ig->glitch($data);

  # or you can get it by file path
  # $glitched = $ig->glitch_file($path_to_image_file);

  $glitched->as_bin; # returns glitched binary data
  $glitched->file_type # returns file type (e.g., image/x-png or image/jpeg)
  $glitched->write($path); # save image to disk


=head1 DESCRIPTION

Image::Glitch is a perl module that makes images cooooool by destroying image data. It emulate aging of image files.

=head1 AUTHOR

Shinpei Maruyama E<lt>shinpeim {at} gmail.comE<gt>

=head1 SEE ALSO

L<http://glitch.so/>
L<http://makebooth.com/i/Tj1Cy>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
