# Staff window

package StaffWindow;

use strict;
use warnings;
use DBI;
use Tk;
require Tk::MiniCalendar;

my $driver = "mysql";
my $database = "staffrecord";
my $dsn = "DBI:mysql:staffrecord";
my $userid = "root";
my $pwd = "root";
my $dbh = DBI -> connect($dsn, $userid, $pwd ) or die $DBI::errstr;

my ($ID, $fullname, $username, $password);
my ($airbusno, $flightname, $journeydate, $departure, $departuretime, $arrival,
        $arrivaltime, $businessfare, $economicalfare, $del_airbusno);
my $str = "Jet Airways  Vistara AirLine  Air India  Spice Jet  IndiGo";
my @flightnames = split("  ", $str);
my @days = qw/Mon Tue Wed Thur Fri Sat Sun/;
my @months = qw/January Febuary March April May June July August September
                October November December/;
our ($staff, $addstaff, $addflight, $delflight);


sub StaffWindow
{
    $staff = MainWindow -> new(-background => 'DarkSlateGray',);
    $staff -> title("Staff Window");
    $staff -> Label
    (
        -text => 'Welcome!',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 17 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $staff -> Button
    (
        -text => 'Add a Staff Member',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {

                $addstaff = MainWindow -> new(-background => 'DarkSlateGray',);
                $addstaff -> title("Add Staff Window");
                $addstaff -> Label
                (
                    -text => 'Add staff details',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 17 bold',
                ) -> pack(-side => 'top', -pady => 10);

                $addstaff -> Label
                (
                    -text => 'Staff ID',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Entry
                (
                    -textvariable => \$ID,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Label
                (
                    -text => 'Full Name',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Entry
                (
                    -textvariable => \$fullname,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Label
                (
                    -text => 'Username',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Entry
                (
                    -textvariable => \$username,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Label
                (
                    -text => 'Password',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Entry
                (
                    -textvariable => \$password,
                    -show => "*",
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addstaff -> Button
                (
                    -text => 'Add Member',
                    -font => 'Roman 14 bold',
                    -command =>
                        sub
                        {
                            my $sth = $dbh -> prepare("insert into Login
                                            values(?, ?, ?, ?)");
                            $sth -> execute($ID, $fullname, $username,
                                                $password) or die;
                            $sth -> finish();

                            $addstaff -> Label
                            (
                                -text => 'Staff Member Added',
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 14 bold',
                            ) -> pack(-side => 'top', -pady => 15);
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 15);

            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -padx => 5, -pady => 10);

    $staff -> Button
    (
        -text => 'Add a flight record',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                my $database = "flightrecord";
                my $dsn = "DBI:mysql:flightrecord";
                my $dbh = DBI -> connect($dsn, $userid, $pwd )
                    or die $DBI::errstr;

                $addflight = MainWindow -> new(-background => 'DarkSlateGray',);
                $addflight -> title("Add flight records");
                $addflight -> Label
                (
                    -text => 'Add flight details',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 17 bold',
                ) -> pack(-side => 'top', -pady => 10);

                $addflight -> Label
                (
                    -text => 'Airbus No.',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$airbusno,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Label
                (
                    -text => 'Flight Name',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Optionmenu
                (
                    -options => \@flightnames,
                    -textvariable => \$flightname,
                    -font => 'Roman 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Button
                (
                    -text => 'Select Journey Date',
                    -font => 'Roman 14 bold',
                    -command =>
                        sub
                        {
                            my $top = MainWindow -> new;
                            my $frm1 = $top -> Frame -> pack;

                            my $minical = $frm1 -> MiniCalendar
                            (
                                -day_names => \@days,
                                -month_names => \@months,
                            ) -> pack;

                            my $frm2 = $top -> Frame -> pack;
                            my $ok = $frm2 -> Button
                            (
                                -text => "Ok",
                                -command =>
                                    sub
                                    {
                                        my ($year, $month, $day)
                                                = $minical -> date;
                                        $journeydate = $year."-".$month
                                                                ."-".$day;
                                        # Date format in sql: YYYY-MM-DD
                                    },
                            ) -> pack;
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 15);

                $addflight -> Label
                (
                    -text => 'Departure',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$departure,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Label
                (
                    -text => 'Departure Time',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$departuretime,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Label
                (
                    -text => 'Arrival',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$arrival,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Label
                (
                    -text => 'Arrival Time',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$arrivaltime,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Label
                (
                    -text => 'Business Fare',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$businessfare,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Label
                (
                    -text => 'Economical fare',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Entry
                (
                    -textvariable => \$economicalfare,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $addflight -> Button
                (
                    -text => 'Add flight record',
                    -font => 'Roman 14 bold',
                    -command =>
                        sub
                        {
                            my $sth = $dbh -> prepare("insert into AirbusRecord
                                            values(?, ?, ?, ?, ?, ?, ?, ?, ?)");
                            $sth -> execute($airbusno, $flightname,
                                        $journeydate, $departure, $departuretime,
                                        $arrival, $arrivaltime, $businessfare,
                                        $economicalfare) or die;
                            $sth -> finish();

                            $addflight -> Label
                            (
                                -text => 'Flight Record Added',
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 14 bold',
                            ) -> pack(-side => 'top', -pady => 15);
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 15);
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -padx => 5, -pady => 10);

    $staff -> Button
    (
        -text => 'Delete Flight Record',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                my $database = "flightrecord";
                my $dsn = "DBI:mysql:flightrecord";
                my $dbh = DBI -> connect($dsn, $userid, $pwd )
                    or die $DBI::errstr;

                $delflight = MainWindow -> new(-background => 'DarkSlateGray',);
                $delflight -> title("Add flight Window");
                $delflight -> Label
                (
                    -text => 'Delete a flight record',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 17 bold',
                ) -> pack(-side => 'top', -pady => 10);

                $delflight -> Label
                (
                    -text => 'Enter Airbus No.',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 2);

                $delflight -> Entry
                (
                    -textvariable => \$del_airbusno,
                    -background => 'SlateGray',
                    -font => 'Georgia 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $delflight -> Button
                (
                    -text => 'Delete',
                    -font => 'Roman 14 bold',
                    -command =>
                        sub
                        {
                            my $sth = $dbh -> prepare("delete from AirbusRecord
                                            where airbusno = \'$del_airbusno\'");
                            $sth -> execute() or die $DBI::errstr;

                            $delflight -> Label
                            (
                                -text => 'Flight Record deleted',
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 14 bold',
                            ) -> pack(-side => 'top', -pady => 15);
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 15);
            },
            -background => 'goldenrod2'
    ) -> pack(-side => 'top', -padx => 5, -pady => 10);

    $staff -> withdraw();
}
1;
