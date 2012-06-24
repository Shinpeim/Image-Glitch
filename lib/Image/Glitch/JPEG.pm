package Image::Glitch::JPEG;
use strict;
use warnings;

my $alnums = [qw/
    0 1 2 3 4 5 6 7 8 9
    a b c d e f g h i j
    k l m n o p q r s t u v w x y z
/];

sub glitch{
    my ($class, $data) = @_;
    my $from = $alnums->[int rand(scalar @$alnums)];
    my $to   = $alnums->[int rand(scalar @$alnums)];
    $data =~ s/$from/$to/g;
    return $data;
}

1;
