use inc::Module::Install;
name 'Image-Glitch';
all_from 'lib/Image/Glitch.pm';

requires 'Compress::Zlib';
requires 'File::Type';
requires 'File::Slurp';
requires 'Carp';
requires 'UNIVERSAL::require';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'FindBin';

test_requires 'File::Spec';

auto_set_repository;
auto_include;
WriteAll;
