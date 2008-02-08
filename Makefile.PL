use inc::Module::Install;
name 'Test-DBICSchemaLoaderDigest';
all_from 'lib/Test/DBICSchemaLoaderDigest.pm';

requires 'Test::More'  => 0.74;
requires 'Exporter'    => 5.58;
requires 'Digest::MD5' => 2.36;

build_requires 'YAML';
use_test_base;
auto_include;
WriteAll;
