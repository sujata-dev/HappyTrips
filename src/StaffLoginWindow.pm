# Staff login window

package StaffLoginWindow;

use strict;
use warnings;
use DBI;
use Tk;

my $driver = "mysql";
my $database = "staffrecord";
my $dsn = "DBI:mysql:staffrecord";
my $userid = "root";
my $pwd = "root";
my $dbh = DBI -> connect($dsn, $userid, $pwd ) or die $DBI::errstr;

my ($newUsername, $newPassword, $actualPassword);
our $stafflogin;


sub StaffLoginWindow
{
    $stafflogin = MainWindow -> new(-background => 'DarkSlateGray',);
    $stafflogin -> title("Staff Login");
    $stafflogin -> Label
    (
        -text => 'For Staff Only',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 17 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $stafflogin -> Label
    (
        -text => 'Login To Continue',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 17 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $stafflogin -> Label
    (
        -text => 'Username',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 13 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $stafflogin -> Entry
    (
        -textvariable => \$newUsername,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $stafflogin -> Label
    (
        -text => 'Password',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 13 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $stafflogin -> Entry
    (
        -textvariable => \$newPassword,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
        -show => "*",
    ) -> pack(-side => 'top', -pady => 2);

    $stafflogin -> Button
    (
        -text => 'Log In',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                my $sth = $dbh -> prepare("select password from Login
                                        where username = \'$newUsername\'");
                $sth -> execute() or die $DBI::errstr;

                while (my $row = $sth -> fetchrow_array())
                {
                    $actualPassword = $row;
                }
                $sth -> finish();

                if($newPassword eq $actualPassword)
                {
                    $StaffWindow::staff -> deiconify();
                    $StaffWindow::staff -> raise();
                    $StaffWindow::staff -> update();
                }
                else
                {
                    $stafflogin -> Label
                    (
                        -text => 'Invalid Email or Password',
                        -foreground => 'white',
                        -background => 'DarkSlateGray',
                        -font => 'Georgia 12 normal',
                    ) -> pack(-side => 'top', -pady => 2);
                }
            },
        -background => 'goldenrod2',
    ) -> pack(-pady => 10);

    $stafflogin -> withdraw(); # hide the Staff Login Window
}
1;
