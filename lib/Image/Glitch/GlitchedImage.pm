package Image::Glitch::GlitchedImage;
use strict;
use warnings;

sub new{
    my ($class, $data, $file_type) = @_;
    bless {
        data      => $data,
        file_type => $file_type,
    }, $class;
}

sub as_bin{
    shift->{data};
}

sub file_type{
    shift->{file_type};
}

sub write{
    my ($self,$path) = @_;
    open(my $fh, '>', $path) or die $!;
    $fh->print($self->as_bin) or die $!;
    close($fh) or die $!;
}

1;
