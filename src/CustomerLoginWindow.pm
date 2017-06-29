# Customer login window

package CustomerLoginWindow;

use strict;
use warnings;
use DBI;
use Tk;

my $driver = "mysql";
my $database = "CustomerRecord";
my $dsn = "DBI:mysql:CustomerRecord";
my $userid = "root";
my $pwd = "root";
my $dbh = DBI->connect($dsn, $userid, $pwd ) or die $DBI::errstr;

our $customer;
my ($newEmail, $newPassword, $actualPassword);


sub CustomerLoginWindow
{
    $customer = MainWindow -> new(-background => 'DarkSlateGray',);
    $customer -> title("Customer Login");
    $customer -> Label
    (
        -text => 'Login To Continue',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 17 bold',
    ) -> pack(-side => 'top', -pady => 15);

    $customer -> Label
    (
        -text => 'Email',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $customer -> Entry
    (
        -textvariable => \$newEmail,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $customer -> Label
    (
        -text => 'Password',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $customer -> Entry
    (
        -textvariable => \$newPassword,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
        -show => "*",
    ) -> pack(-side => 'top', -pady => 2);

    $customer -> Button
    (
        -text => 'Log In',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                my $sth = $dbh -> prepare("select password
                                            from Registration
                                            where email = \'$newEmail\'");
                $sth->execute() or die $DBI::errstr;

                while (my @row = $sth -> fetchrow_array())
                {
                    $actualPassword = $row[0];
                }
                $sth -> finish();

                if($newPassword eq $actualPassword)
                {
                    $UserWindow::user -> deiconify();
                    $UserWindow::user -> raise();
                }
                else
                {
                    $customer -> Label
                    (
                        -text => 'Invalid Email or Password',
                        -foreground => 'white',
                        -background => 'DarkSlateGray',
                        -font => 'Georgia 12 normal',
                    ) -> pack(-side => 'top', -pady => 2);
                }
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'top', -pady => 10);

    $customer -> withdraw(); # hide the Customer Register/Login Window
}
1;
