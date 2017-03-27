package SumGraph::Web::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

# This action will render a template
sub index {
  my $self = shift;
  # Render template "example/index.html.ep" with message
  $self->reply->static('index.html');
}

sub sumgraph {
  my $self = shift;
  
  my $json = $self->req->json;
  my $start = $json->{"start"};
  my $end = $json->{"end"};
  my $unit = $json->{"unit"};
  my %LEN = ( "year" => 4,  "month"  => 7,  "day"    => 10,
              "hour" => 13, "minute" => 16, "second" => 19); 
  my $len = 19;
  if (defined($unit) && defined($LEN{$unit})){
    $len = $LEN{$unit};
  }
  printf( $len);;
  my @datas = ();
  if (defined($start)){
    if (defined($end)){
      @datas = grep {$_->{"timestamp"} ge $start && 
                     $_->{"timestamp"} le $end} @{$self->datas};
    }
    else{
      @datas = grep {$_->{"timestamp"} ge $start} @{$self->datas};
    }
  }
  else{
    if (defined($end)){
      @datas = grep {$_->{"timestamp"} le $end} @{$self->datas};
    }
    else{
      @datas = @{$self->datas};
    }
  }
  my @ret = ();
  while(1) {
    my %sum = ();
    foreach my $data(@datas){
      my $timestamp = substr($data->{"timestamp"}, 0 , $len);
      if (defined($sum{$timestamp})){
        my $hash = $sum{$timestamp};
        foreach my $key(keys $data){
          if ( $key ne "timestamp"){
            $hash->{$key} = $hash->{$key} + $data->{$key}; 
          }
        }
      }
      else{
        my %copy = %$data;
        $copy{"timestamp"} = $timestamp;
        $sum{$timestamp} = \%copy; 
      }
    }

    @ret = sort { $a->{timestamp} cmp $b->{timestamp}} values %sum;
    print Dumper(@ret);
    my $ret_len = scalar @ret;
    $len = $len + 3;
    if ($len > 19 || $ret_len >= 1) {
      last;
    }
  } 
  $self->render(json => \@ret);
}
1;
