package Image::Glitch::PNG;
use strict;
use warnings;
use Compress::Raw::Zlib;

my $alnums = [qw/
    0 1 2 3 4 5 6 7 8 9
    a b c d e f g h i j
    k l m n o p q r s t
    u v w x y z
/];

sub glitch{
    my ($class,$data) = @_;

    my $parsed_data = _parse($data);

    my $x = Compress::Raw::Zlib::Inflate->new;
    $x->inflate($parsed_data->{body}, my $raw);

    my $from = $alnums->[int rand(scalar @$alnums)];
    my $to   = $alnums->[int rand(scalar @$alnums)];
    $raw =~ s/$from/$to/g;

    my $d = Compress::Raw::Zlib::Deflate->new(
        '-AppendOutput' => 1,
    );
    $d->deflate($raw, my $compressed);
    $d->flush($compressed);

    my $size = pack('N',length($compressed));
    my $body = $size.'IDAT'.$compressed;
    my $crc = pack('N',crc32($compressed,crc32('IDAT')));

    my $glitched_data = $parsed_data->{head}.$body.$crc.$parsed_data->{tail};
    return $glitched_data;
}

sub _parse{
    my $data = shift;

    my ($size,$head,$idats,$tail) = (0,"",[],"");
    my @data = split(/IDAT/,$data);
    foreach my $datum (@data){
        if ($size == 0){
            $head = substr($datum, 0, length($datum) - 4);
        }
        if ($size > 0) {
            push @$idats, substr($datum, 0, $size);
        }
        $tail = substr($datum,($size + 4),(-$size + 4));
        $size = unpack('Na',substr($datum, length($datum) - 4, 4));
    }
    return {
        head => $head,
        body => join('',@$idats),
        tail => $tail,
        size => $size,
    };
}

1;
