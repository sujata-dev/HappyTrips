# Customer registration success window

package CustomerRegistrationSuccess;

use strict;
use warnings;
use Tk;

our $CustRegDone;


sub CustomerRegistrationSuccess
{
    $CustRegDone = MainWindow -> new(-background => 'DarkSlateGray',);
    $CustRegDone -> title("Registration Complete");
    $CustRegDone -> Label
    (
        -text => 'Welcome To',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 15);

    $CustRegDone -> Label
    (
        -text => '_HappyTrips_',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Roman 20 italic',
    ) -> pack(-side => 'top', -pady => 15);

    $CustRegDone -> Label
    (
        -text => 'You have successfully signed in.',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 15);

    $CustRegDone -> Label
    (
        -text => 'Now Log In to continue',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 15);

    $CustRegDone -> withdraw();
}
1;
