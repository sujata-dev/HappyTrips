# Customer flight booking window

package BookFlight;

use strict;
use warnings;
use DBI;
use Tk;
require Tk::MiniCalendar;

my $driver = "mysql";
my $database = "flightrecord";
my $dsn = "DBI:mysql:flightrecord";
my $userid = "root";
my $pwd = "root";
my $dbh = DBI -> connect($dsn, $userid, $pwd ) or die $DBI::errstr;

my (@statelist, @cityfromlist, @citytolist);
my @days = qw/Mon Tue Wed Thur Fri Sat Sun/;
my @months = qw/January Febuary March April May June July August September
                October November December/;
my @ClassofTravel = qw/Economy Business/;
my ($adults, $children, $infants) = (1, 0, 0);
my ($i, $statefrom, $stateto, $TravelClass, $cityfrom, $cityto, $journeyDate,
        $departuretime, $arrivaltime, $airbusno, $flightname, $businessfare,
        $economicalfare, $fare, $price, $row);
my @flightinfo;
our ($userBookFlight, $flightlist);


sub BookFlight
{
    $userBookFlight = MainWindow -> new(-background => 'DarkSlateGray');
    $userBookFlight -> title("Book a flight");
    $userBookFlight -> Label
    (
        -text => ' FILL IN THE BOXES TO GET A LIST OF FLIGHTS AVAILABLE ',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 7);

    $userBookFlight -> Label
    (
        -text => 'CLASS OF TRAVEL',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Optionmenu
    (
        -options => \@ClassofTravel,
        -textvariable => \$TravelClass,
    ) -> pack(-side=>'top', -pady => 2);

    $userBookFlight -> Label
    (
        -text => 'Enter no. of adults (12+ yrs)',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Entry
    (
        -textvariable => \$adults,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Label
    (
        -text => 'Enter no. of children (2-11 yrs)',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Entry
    (
        -textvariable => \$children,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Label
    (
        -text => 'Enter no. of infants (under  2 yrs)',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Entry
    (
        -textvariable => \$infants,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Label
    (
        -text => 'WHEN?',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 5);

    $userBookFlight -> Button
    (
        -text => 'Click to select date',
        -font => 'Roman 12 bold',
        -command =>
            sub
            {
                my $top = MainWindow -> new;
                my $frm1 = $top -> Frame -> pack;   # Frame for MiniCalendar

                my $minical = $frm1 -> MiniCalendar
                (
                    -day_names => \@days,
                    -month_names => \@months,
                ) -> pack;

                my $frm2 = $top -> Frame -> pack;  # Frame for Ok Button
                my $ok = $frm2 -> Button
                (
                    -text => "Ok",
                    -command =>
                        sub
                        {
                            my ($year, $month, $day) = $minical -> date;
                            $journeyDate = $year."-".$month."-".$day;
                            # Date format in sql: YYYY-MM-DD
                            print $journeyDate;
                        },
                ) -> pack;
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Label
    (
        -text => 'WHERE?',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 5);

    $userBookFlight -> Label
    (
        -text => 'From (Select a state)',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 bold',
    ) -> pack(-side => 'top', -pady => 2);

    my $sth = $dbh -> prepare("select distinct state
                                from aircodes
                                order by state;");
    $sth -> execute() or die $DBI::errstr;

    my $data = $sth -> fetchall_arrayref();
    $sth -> finish;

    $i = 0;
    foreach $data (@$data)
    {
        @statelist[$i] = @$data;
        $i++;
    }

    $userBookFlight -> Optionmenu
    (
        -options => \@statelist,
        -textvariable => \$statefrom,
        -font => 'Roman 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Button
    (
        -text => 'Click to select your current city',
        -font => 'Roman 12 bold',
        -command =>
            sub
            {
                my $sth = $dbh->prepare("select city from aircodes
                                            where state=\'$statefrom\'
                                            order by city");
                $sth -> execute() or die $DBI::errstr;

                my $data = $sth -> fetchall_arrayref();
                $sth -> finish;

                $i = 0;
                foreach $data (@$data)
                {
                    @cityfromlist[$i] = @$data;
                    $i++;
                }

                $userBookFlight -> Optionmenu
                (
                    -options => \@cityfromlist,
                    -font => 'Roman 10 bold',
                    -textvariable => \$cityfrom,
                ) -> pack(-side => 'top', -pady => 2);

                $userBookFlight -> Label
                (
                    -text => 'To (Select a state)',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $userBookFlight -> Optionmenu
                (
                    -options => \@statelist,
                    -textvariable => \$stateto,
                    -font => 'Roman 10 bold',
                ) -> pack(-side => 'top', -pady => 2);

                $userBookFlight -> Button
                (
                    -text => 'Click to select your destination city',
                    -font => 'Roman 12 bold',
                    -command =>
                        sub
                        {
                            my $sth = $dbh -> prepare("select city
                                                        from aircodes
                                                    where state = \'$stateto\'
                                                        order by city ");
                            $sth -> execute()
                            or die $DBI::errstr;

                            my $data = $sth -> fetchall_arrayref();
                            $sth -> finish;

                            $i = 0;
                            foreach $data (@$data)
                            {
                                @citytolist[$i] = @$data;
                                $i++;
                            }

                            $userBookFlight -> Optionmenu
                            (
                                -options => \@citytolist,
                                -font => 'Roman 10 bold',
                                -textvariable => \$cityto
                            ) -> pack(-side => 'top', -pady => 2);
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 2);
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 2);

    $userBookFlight -> Button
    (
        -text => 'CHECK FLIGHTS',
        -font => 'Roman 12 bold',
        -command =>
            sub
            {
                # Flight list window
                $flightlist = MainWindow -> new(-background => 'DarkSlateGray');
                $flightlist -> title("List of Flights");
                $flightlist -> Label
                (
                    -text => 'List of flights available (Select any one)',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 15 bold',
                ) -> pack(-side => 'top', -pady => 7);

                my $sth = $dbh -> prepare("select \* from AirbusRecord
                                            where departure = \'$cityfrom\'
                                            and arrival = \'$cityto\' and
                                            journeydate = \'$journeyDate\';");
                $sth -> execute() or die $DBI::errstr;

                $i = 0;
                while(my @row = $sth -> fetchrow_array())
                {
                    my ($airbusno, $flightname, $journeyDate, $cityfrom,
                        $departuretime, $cityto, $arrivaltime, $businessfare,
                        $economicalfare) = @row;

                    $fare = ($TravelClass eq "Economy") ? $economicalfare :
                                                                $businessfare;
                    $flightinfo[$i] = $airbusno." ".$flightname." ".$journeyDate.
                                " ".$cityfrom." ".$departuretime." ".$cityto.
                                " ".$arrivaltime." ".$fare." ";
                    $i++;
                }
                $sth -> finish;

                $flightlist -> Label
                (
                    -text => 'AirbusNo FlightName Date Departure Arrival'.
                                'Price(INR)',
                    -foreground => 'white',
                    -background => 'DarkSlateGray',
                    -font => 'Georgia 12 normal',
                ) -> pack(-side => 'top', -pady => 7);

                $flightlist -> Optionmenu
                (
                    -options => \@flightinfo,
                    -font => 'Georgia 12 normal',
                    -textvariable => \$row
                ) -> pack(-side => 'top', -pady => 2);

                ($airbusno, $flightname, $journeyDate, $cityfrom,
                    $departuretime, $cityto, $arrivaltime, $fare)
                    = split(' ',$row);

                $price = ($fare * $adults) + (($fare / 2) * $children);

                $flightlist -> Button
                (
                    -text => 'Book ticket',
                    -font => 'Roman 12 bold',
                    -command =>
                        sub
                        {
                            my $database = "CustomerRecord";
                            my $dsn = "DBI:mysql:CustomerRecord";
                            my $dbh = DBI -> connect($dsn, $userid, $pwd )
                                or die $DBI::errstr;

                            $sth = $dbh -> prepare("insert into Airticket
                                    (airbusno, flightname, travelclass, date,
                                    departuretime, arrivaltime, adults,
                                    children, infants, cityfrom, cityto, fare)
                                    values
                                    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");

                            $sth -> execute($airbusno, $flightname,
                                $TravelClass, $journeyDate, $departuretime,
                                $arrivaltime, $adults, $children, $infants,
                                $cityfrom, $cityto, $price) or die;
                            $sth -> finish();

                            $flightlist -> Label
                            (
                                -text => 'Price = '.$price,
                                -foreground => 'white',
                                -background => 'DarkSlateGray',
                                -font => 'Georgia 15 normal',
                            ) -> pack(-side => 'top', -pady => 7);

                            $flightlist -> Button
                            (
                                -text => 'Proceed for Payment',
                                -font => 'Roman 12 bold',
                                -command =>
                                    sub
                                    {
                                        #$TicketPaymentWindow::pay -> deiconify();
                                        #$TicketPaymentWindow::pay -> raise();
                                    }
                                -background => 'goldenrod2'
                            ) -> pack(-side => 'top', -pady => 7);
                        },
                    -background => 'goldenrod2'
                ) -> pack(-side => 'top', -pady => 10);
            },
        -background => 'DeepSkyBlue'
    ) -> pack(-side => 'bottom', -pady => 2);

    $userBookFlight -> withdraw();
}
1;
