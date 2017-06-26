# User logged in window

package UserWindow;

use strict;
use warnings;
use DBI;
use Tk;

our $user;


sub UserWindow
{
    $user = MainWindow -> new(-background => 'DarkSlateGray',);
    $user -> title("Welcome User");
    $user -> Label
    (
        -text => 'Welcome User',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 17 bold',
    ) -> pack(-side => 'top', -pady => 15);

    $user -> Label
    (
        -text => 'Select one to get started',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 17 bold',
    ) -> pack(-side => 'top', -pady => 15);

    $user -> Button
    (
        -text => 'Book a Flight',
        -font => 'Roman 14 bold',
        -command => sub
                    {
                        $BookFlight::userBookFlight -> deiconify();
                        $BookFlight::userBookFlight -> raise();
                    },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 10);

    $user -> Button
    (
        -text => 'Change a booking',
        -font => 'Roman 14 bold',
        -command => sub
                    {

                    },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 10);

    $user -> Button
    (
        -text => 'Terminate a booking',
        -font => 'Roman 14 bold',
        -command => sub
                    {

                    },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 10);

    $user -> withdraw();
}
1;
