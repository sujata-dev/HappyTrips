# User logged in window

package UserWindow;

use strict;
use warnings;
use DBI;
use Tk;

my $driver = "mysql";
my $database = "CustomerRecord";
my $dsn = "DBI:mysql:CustomerRecord";
my $userid = "root";
my $pwd = "root";
my $dbh = DBI -> connect($dsn, $userid, $pwd ) or die $DBI::errstr;

my ($eticketno, $fare, $cancellationfare, $refund);
our ($user, $cancelbooking);


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
        -text => 'Book a flight ticket',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                $BookFlight::userBookFlight -> deiconify();
                $BookFlight::userBookFlight -> raise();
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 10);

    $user -> Button
    (
        -text => 'Terminate a booking',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                $cancelbooking = MainWindow -> new(-background => 'DarkSlateGray');
                $cancelbooking -> title("Add flight Window");

                $cancelbooking -> Label
                (
                    -text => 'Enter eticket number to cancel your booking',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $cancelbooking -> Entry
                (
                    -textvariable => \$eticketno,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $cancelbooking -> Button
                (
                    -text => 'Cancel Booking',
                    -font => 'Roman 14 bold',
                    -command =>
                        sub
                        {
                            my $sth = $dbh -> prepare("select fare from Airticket
                                            where eticketno = \'$eticketno\'");
                            $sth -> execute() or die $DBI::errstr;

                            while (my $row = $sth -> fetchrow_array())
                            {
                                $fare = $row;
                            }

                            $cancellationfare = 0.25 * $fare;
                            $refund = $fare - $cancellationfare;

                            $sth = $dbh -> prepare("delete from Airticket
                                            where eticketno = \'$eticketno\'");
                            $sth -> execute() or die $DBI::errstr;

                            $cancelbooking -> Label
                            (
                                -text => 'Booking Cancelled',
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 14 bold',
                            ) -> pack(-side => 'top', -pady => 15);

                            $cancelbooking -> Label
                            (
                                -text => 'Cancellation Charges: '.
                                                        $cancellationfare,
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 12 bold',
                            ) -> pack(-side => 'top', -pady => 2);

                            $cancelbooking -> Label
                            (
                                -text => 'Refundable Amount: '.$refund,
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 12 bold',
                            ) -> pack(-side => 'top', -pady => 2);
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 15);
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 10);

    $user -> withdraw();
}
1;
