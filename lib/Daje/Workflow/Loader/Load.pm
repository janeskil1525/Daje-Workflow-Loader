package Daje::Workflow::Loader::Load;
use Mojo::Base -base, -signatures;

use Mojo::JSON qw {decode_json from_json};
use Mojo::File;

# NAME
# ====
#
# Daje::Workflow::Loader::Load - It's new $module
#
# SYNOPSIS
# ========
#
#    use Daje::Workflow::Loader::Load;
#
#    my $workflow = Daje::Workflow::Loader::Load->(
#       path => "path"
#    )->load();
#
# DESCRIPTION
# ===========
#
# Daje::Workflow::Loader::Load is loading workflows from JSON files in a set folder
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

has 'path';

# Load all workflows in the given path
sub load($self) {
    my $collection = $self->_load_list();

    my $workflow;
    $collection->each(sub ($e, $num) {
        my $path = Mojo::File->new($e);
        my $tag = substr( $path->basename(), 0, index( $path->basename(), '.json'));
        if($tag ne "database") {
            $workflow->{$tag} = from_json($path->slurp())->{workflow};
        } else {
            $workflow->{$tag} = from_json($path->slurp());
        }
    });

    return $workflow;
}

# List of workflows in path (for internal use)
sub _load_list($self) {
    my $collection;
    eval {
        my $path = Mojo::File->new($self->path());
        $collection = $path->list();
    };

    return $collection;
}
1;



#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME


Daje::Workflow::Loader::Load - It's new $module



=head1 SYNOPSIS


   use Daje::Workflow::Loader::Load;

   my $workflow = Daje::Workflow::Loader::Load->(
      path => "path"
   )->load();



=head1 DESCRIPTION


Daje::Workflow::Loader::Load is loading workflows from JSON files in a set folder



=head1 REQUIRES

L<Mojo::File> 

L<Mojo::JSON> 

L<Mojo::Base> 


=head1 METHODS

=head2 load($self)

 load($self)();

Load all workflows in the given path



=head1 AUTHOR


janeskil1525 E<lt>janeskil1525@gmail.comE<gt>



=head1 LICENSE


Copyright (C) janeskil1525.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.



=cut

