#!/usr/bin/perl

# which-sem.pl
# given a list of UNSW course codes, return when the courses run in table form

use warnings;
use strict;

use Data::Dumper;

my $debug = 1;

my %courses;

# read course codes into courses hash
while(my $code = <>) {

    # clean code
    chomp $code;
    $code = uc $code;

    # check code is legal (legal code is four letters followed by four numbers)
    #  and add to hash
    # TODO check that course exists, may not be neccesary
    if((my $legal_code) = $code =~ /^\s*([A-Z]{4}\d{4})\s*$/) {
        $courses{$legal_code}{"T1"} = 0;
        $courses{$legal_code}{"T2"} = 0;
        $courses{$legal_code}{"U1"} = 0;
    } else {
        # TODO better error handling
        print "Illegal course code: $code \n";
    }
}

if($debug) {
    print Dumper(\%courses);
}


# update courses hash with when the courses are running
foreach my $course (keys %courses) {
    # fetch web page for course
    my $url = "timetable.unsw.edu.au/current/$course.html";
    open WEB_PAGE, "wget -q -O- $url|" or die;

    # figure out which semesters the course runs in and update hash
    while(my $line = <WEB_PAGE>) {
        # exit loop if no course info
        last if $line =~ /information for the selected course was not found/i;

        # only need to search lines above this line (SUMMARY OF SEMESTER 1/SEMESTER 2/SUMMER TERM CLASSES)
        last if $line =~ /summary of/i;

        foreach my $sem (keys $courses{$course}) {
            if($line =~ /$sem/) {
                $courses{$course}{$sem} = 1;
            }
        }
    }
}

if($debug) {
    print Dumper(\%courses);
}


# display courses in table
