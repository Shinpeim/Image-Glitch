use strict;
use warnings;
use Test::More;
use FindBin;
use File::Spec;
use File::Slurp;
use Image::Glitch;

my $data_dir = File::Spec->catfile($FindBin::RealBin, "data");
my $ig = Image::Glitch->new;

subtest "can detect png format", sub {
    my $data = read_file(File::Spec->catfile($data_dir, "test.png"));
    is $ig->_detect_format($data), "image/x-png";
};

subtest "can detect detect format", sub {
    my $data = read_file(File::Spec->catfile($data_dir, "test.jpg"));
    is $ig->_detect_format($data), "image/jpeg";
};

done_testing;
