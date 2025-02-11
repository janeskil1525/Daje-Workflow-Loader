package Daje::Workflow::Loader;
use Mojo::Base -base, -signatures;



# NAME
# ====
#
# Daje::Workflow::Loader - Just loads Daje-Workflow JSON based workflows
#
#
# SYNOPSIS
# ========
#
#    use Daje::Workflow::Loader;
#
#    my $workflows = Daje::Workflow::Loader->new(
#         path => 'path
#    )->load();
#
#    my $workflow = $workflows->get_workflow('workflow');
#
#    my $state = $workflows->get_state('workflow','state');
#
#    my $pre_checks = $workflows->get_pre_checks('workflow','state');
#
#    my $post_checks = $workflows->get_post_checks('workflow','state');
#
#    my $activity = get_activity($workflow, $state_name, $activity_name);
#
# DESCRIPTION
# ===========
#
# Daje::Workflow::Loader is a workflow loader for
#
# the Daje-Workflow engine
#
# LICENSE
# =======
#
# Copyright (C) janeskil1525.
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# AUTHOR
# ======
#
# janeskil1525 E<lt>janeskil1525@gmail.comE<gt>
#

use Daje::Workflow::Roadmap::Load;;
use Daje::Workflow::Details::Analyser;

has 'path';
has 'error';
has 'has_error' => 0;
has 'loader';

our $VERSION = "0.08";

# Load the data into the object
sub load($self) {
    eval {
        my $loader = Daje::Workflow::Roadmap::Load->new(
            type => 'workflow',
            path => $self->path(),
        );
        $loader->load();
        $self->loader($loader);
    };
    $self->add_error($@) if $@;

    if($self->has_error() == 0) {
        eval {
            my $analyzer = Daje::Workflow::Details::Analyser->new(
                loader => $self->loader()
            )->analyze();
        }
    }
    $self->add_error($@) if $@;

    return 1;
}

sub add_error($self, $error =  "") {
    return 1 unless length($error) > 0;

    my $err = $self->error();
    $err = "" unless $err;
    $self->error($err . ' ' . $error);
    $self->has_error(0);
}
1;
__END__











#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME


Daje::Workflow::Loader - Just loads Daje-Workflow JSON based workflows




=head1 SYNOPSIS


   use Daje::Workflow::Loader;

   my $workflows = Daje::Workflow::Loader->new(
        path => 'path
   )->load();

   my $workflow = $workflows->get_workflow('workflow');

   my $state = $workflows->get_state('workflow','state');

   my $pre_checks = $workflows->get_pre_checks('workflow','state');

   my $post_checks = $workflows->get_post_checks('workflow','state');

   my $activity = get_activity($workflow, $state_name, $activity_name);



=head1 DESCRIPTION


Daje::Workflow::Loader is a workflow loader for

the Daje-Workflow engine



=head1 REQUIRES

L<Daje::Config> 

L<Mojo::Base> 


=head1 METHODS

=head2 get_activity($self,

 get_activity($self,();

=head2 get_next_state($self,

 get_next_state($self,();

=head2 get_post_checks($self,

 get_post_checks($self,();

=head2 get_pre_checks($self,

 get_pre_checks($self,();

=head2 get_state($self,

 get_state($self,();

=head2 get_state_observers($self,

 get_state_observers($self,();

=head2 get_workflow($self,

 get_workflow($self,();

Get the entire workflow as a hashref


=head2 load($self)

 load($self)();

Load the data into the object



=head1 AUTHOR


janeskil1525 E<lt>janeskil1525@gmail.comE<gt>



=head1 LICENSE


Copyright (C) janeskil1525.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.



=cut

