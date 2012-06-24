use strict;
use warnings;
use Test::More;
use FindBin;
use File::Slurp;
use File::Spec;
use Image::Glitch;
use File::Temp ();

subtest "can write glitched file", sub {
    my $data_dir = File::Spec->catfile($FindBin::RealBin, "data");
    my $ig = Image::Glitch->new;

    my $path = File::Spec->catfile($data_dir, "test.png");
    my $data = read_file($path);
    my $glitched = $ig->glitch_file($path);

    my $fh = File::Temp->new;
    $glitched->write($fh->filename) or die $!;
    my $saved_data = read_file($fh->filename);
    ok $saved_data eq $glitched->as_bin, "saved file is eq to glitched_data";
};

done_testing;
