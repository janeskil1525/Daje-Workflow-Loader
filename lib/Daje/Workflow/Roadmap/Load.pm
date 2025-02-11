package Daje::Workflow::Roadmap::Load;
use Mojo::Base -base, -signatures;


use Daje::Config;

has 'workflow';
has 'path';

sub load($self) {

    my $workflow = Daje::Config->new(
        path => $self->path,
        type => 'workflow',
    )->load();
    $self->workflow($workflow);

    return 1;
}


# Get the entire workflow as a hashref
sub get_workflow($self, $workflow) {
    return $self->workflow()->{workflow};
}

#
sub get_state($self, $workflow, $state_name) {
    my $flow = $self->workflow->{$workflow};
    my $length = scalar @{$flow};
    my $state;
    for (my $i = 0; $i < $length; $i++) {
        if (@{$flow}[$i]->{name} eq $state_name) {
            $state = @{$flow}[$i];
        }
    }

    return $state;
}

sub get_pre_checks($self, $workflow, $state_name) {
    my $state = $self->get_state($workflow, $state_name);
    return $state->{state}->{pre_checks};
}

sub get_post_checks($self, $workflow, $state_name) {
    my $state = $self->get_state($workflow, $state_name);
    return $state->{state}->{post_checks};
}

sub get_next_state($self, $workflow, $state_name) {
    my $state = $self->get_state($workflow, $state_name);
    return $state->{next_state};
}

sub get_state_observers($self, $workflow, $state_name) {
    my $state = $self->get_state($workflow, $state_name);
    return $state->{state}->{observers};
}

sub get_activity($self, $workflow, $state_name, $activity_name) {
    my $activity;
    my $activities = $self->get_state($workflow, $state_name)->{state}->{activities};
    my $length = scalar @{$activities};
    for (my $i = 0; $i < $length; $i++) {
        if (@{$activities}[$i]->{name} eq $activity_name) {
            $activity = @{$activities}[$i];
        }
    }
    return $activity;
}


1;