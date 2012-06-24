use strict;
use warnings;
use Test::More;
use FindBin;
use File::Spec;
use File::Slurp;
use Image::Glitch;

my $data_dir = File::Spec->catfile($FindBin::RealBin, "data");
my $ig = Image::Glitch->new;

subtest "can glitch png file", sub {
    my $data = read_file(File::Spec->catfile($data_dir, "test.png"));
    my $glitched = $ig->glitch($data);
    is $ig->_detect_format($glitched), "image/x-png", "glitched png must be png";
    ok $glitched ne $data, "glitched png must be GLITCHED :)";
};

subtest "can glitch jpeg file", sub {
    my $data = read_file(File::Spec->catfile($data_dir, "test.jpg"));
    my $glitched = $ig->glitch($data);
    is $ig->_detect_format($glitched), "image/jpeg", "glitched png must be jpeg";
    ok $glitched ne $data, "glitched jpeg must be GLITCHED :)";
};

done_testing;
