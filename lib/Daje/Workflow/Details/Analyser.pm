package Daje::Workflow::Details::Analyser;
use Mojo::Base -base, -signatures;


has 'workflow';
has 'wfl_activities';
has 'workflows';
has 'activities';
has 'states';
has 'loader';

sub analyze($self) {
    my $endpoints;
    my $workflow = $self->loader()->workflow();
    for (my ($wfl_key, $wfl_val) = each(%{$workflow})) {
        my $len = scalar @{$wfl_val};
        for(my $j = 0; $j < $len; $j++) {
            my $activities = @{$wfl_val}[$j]->{state}->{activities};
            my $leng = scalar @{activities};
            for(my $k = 0; $k < $leng; $k++) {
                my $endpoint->{workflow} = $wfl_key;
                $endpoint->{state} = @{$wfl_val}[$j]->{name};;
                $endpoint->{activity} = @{activities}[$k]->{name};
                push @{$endpoints}, $endpoint;
            }

        }
        my $test = 1;
    }
}

sub _analyze($self) {

}

1;