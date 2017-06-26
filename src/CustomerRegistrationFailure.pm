# Customer registration failure window

package CustomerRegistrationFailure;

use strict;
use warnings;
use Tk;

our $CustRegNotDone;


sub CustomerRegistrationFailure
{
    $CustRegNotDone = MainWindow -> new(-background => 'DarkSlateGray',);
    $CustRegNotDone -> title("Registration Failed");
    $CustRegNotDone -> Label
    (
        -text => '!',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 35 bold',
    ) -> pack(-side => 'top', -pady => 5);

    $CustRegNotDone -> Label
    (
        -text => 'Sorry',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $CustRegNotDone -> Label
    (
        -text => 'Your request could not be processed',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $CustRegNotDone -> Label
    (
        -text => 'Please try again',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $CustRegNotDone -> withdraw();
}
1;
