use inc::Module::Install;
name 'Image-Glitch';
all_from 'lib/Image/Glitch.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
