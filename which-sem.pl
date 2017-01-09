#!/usr/bin/perl

# which-sem.pl
# given a list of UNSW course codes, return when the courses run in table form

use warnings;
use strict;

use Data::Dumper;

my $debug = 1;

# TODO get current year from computer
my $year = 2017;

my %courses;

# read course codes into courses hash
while(my $code = <>) {

    # convert to upper case
    $code = uc $code;

    # check code is legal, legal code is four letters followed by four numbers
    # TODO check that course exists, may not be neccesary
    if($code =~ /^\s*[A-Z]{4}\d{4}\s*$/) {
        $courses{$code} = "";
    } else {
        # TODO better error handling
        die "Illegal course code\n";
    }
}

if($debug) {
    print Dumper(\%courses);
}




# update courses hash with when the courses are running



# display courses in table
