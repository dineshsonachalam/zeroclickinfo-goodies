use strict;
use warnings;

use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'bashprimaryexpressions';

ddg_goodie_test(
	[
		'DDG::Goodie::BashPrimaryExpressions'
	],
	"bash [ -a b ]" => test_zci(
		"[ -a b ] - True if b exists"
	),
	'bash [[ "abc" < "cba" ]]' => test_zci(
		'[[ "abc" < "cba" ]] - True if "abc" string-sorts before "cba" in the current locale'
	),
	'bash [ 2 -gt 1 ]' => test_zci(
		'[ 2 -gt 1 ] - True if 2 is numerically greater than 1'
	),
	'bash [ ! hello == world ]' => test_zci(
		'[ ! hello == world ] - False if the strings hello and world are equal'
	)
);

done_testing;