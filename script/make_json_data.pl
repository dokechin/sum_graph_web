use strict;
use warnings;
use Data::Dumper;
use JSON;

my @datas = ();
my $time = time - (3600 * 24 * 10); 
while ($time < time){
    my ($sec, $min, $hour, $day,$month,$year) = (localtime($time))[0,1,2,3,4,5];
    my $timestamp = sprintf("%04d-%02d-%02d %02d:%02d:%02d", 
        $year + 1900, $month + 1 , $day, $hour, $min, $sec);
    push (@datas, {timestamp => $timestamp, 
                   temp => int(rand(30)), 
                   humidity => int(rand(100))});
    $time = $time + 60 * 60;
}

print to_json({datas => \@datas}, {pretty => 1});
