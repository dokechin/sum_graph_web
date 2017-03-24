package SumGraph::Web;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  my $config = $self->plugin('JSONConfig');
  $self->helper(datas => sub { $self = shift;
    return $config->{"datas"};
  });

  my $r = $self->routes;

  $r->get('/')->to('example#index');
  $r->post('/sumgraph')->to('example#sumgraph');
}

1;
