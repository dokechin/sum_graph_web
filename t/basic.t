use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('SumGraph::Web');
$t->post_ok('/sumgraph')
  ->status_is(200);
$t->post_ok('/sumgraph'=> form => {start => "2017-03-02 23:14:14"})
  ->status_is(200);
$t->post_ok('/sumgraph'=> form => {start => "2017-03-02 23:15:15"})
  ->status_is(200);
$t->post_ok('/sumgraph'=> form => {unit => "year"})
  ->status_is(200);

done_testing();
