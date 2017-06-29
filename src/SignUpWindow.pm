# Customer sign up window

package SignUpWindow;

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
my ($firstname, $lastname, $age, $email, $password, $cpassword, $mobile);
my $gender = 'female';


sub SignUpWindow
{
    my $main = MainWindow -> new(-background => 'DarkSlateGray');
    $main -> title("HappyTrips");
    $main -> Label
    (
        -text => '_HappyTrips_',
        -font => 'Roman 20 italic',
        -foreground =>'white',
        -background => 'DarkSlateGray',
    ) -> pack(-side => 'top', -pady => 10);

    $main -> Label
    (
        -text => 'Get awesome deals on air tickets!!',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Courier 17 bold',
    ) -> pack(-side => 'top', -pady => 5);

    $main -> Label
    (
        -text => 'Enter details to sign up',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 15 bold',
    ) -> pack(-side => 'top', -pady => 10);

    $main -> Label
    (
        -text => 'First Name',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Entry
    (
        -textvariable => \$firstname,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Label
    (
        -text => 'Last Name',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Entry
    (
        -textvariable => \$lastname,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Label
    (
        -text => 'Gender',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Radiobutton
    (
        -text => 'Male',
        -value => 'Male',
        -variable => \$gender,
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 11 bold',
    ) -> pack;

    $main -> Radiobutton
    (
        -text => 'Female',
        -value =>'Female',
        -variable => \$gender,
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 11 bold',
    ) -> pack;

    $main -> Label
    (
        -text => 'Age',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Entry
    (
        -textvariable => \$age,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Label
    (
        -text => 'Email',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Entry
    (
        -textvariable => \$email,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Label
    (
        -text => 'Password*',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Entry
    (
        -textvariable => \$password,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
        -show => "*",
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Label
    (
        -text => 'Confirm Password',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Entry
    (
        -textvariable => \$cpassword,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
        -show => "*",
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Label
    (
        -text => '*Password should be between 8-13 characters. It should ' .
                    'contain at least one alphabet and one numeric digit.',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 10 normal',
    ) -> pack(-side => 'bottom', -pady => 2);

    $main -> Label
    (
        -text => 'Mobile',
        -foreground => 'white',
        -background => 'DarkSlateGray',
        -font => 'Georgia 12 normal',
    ) -> pack(-side => 'top', -pady => 2);

    $main->Entry
    (
        -textvariable => \$mobile,
        -background => 'SlateGray',
        -font => 'Georgia 10 bold',
    ) -> pack(-side => 'top', -pady => 2);

    $main -> Button
    (
        -text => 'SignUp',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                if($password eq $cpassword && $password =~
                    /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,13}$/ &&
                    $mobile =~ /^\d{10}$/)
                {
                    $CustomerRegistrationSuccess::CustRegDone -> deiconify();
                    $CustomerRegistrationSuccess::CustRegDone -> raise();

                    my $sth = $dbh -> prepare("insert into Registration
                                            values(?, ?, ?, ?, ?, ?, ?, ?)");
                    $sth -> execute($firstname, $lastname, $gender, $age,
                                $email, $password, $cpassword, $mobile) or die;
                    $sth -> finish();
                }
                else
                {
                    $CustomerRegistrationFailure::CustRegNotDone -> deiconify();
                    $CustomerRegistrationFailure::CustRegNotDone -> raise();
                }
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'left', -padx => 5, -pady => 10);

    $main -> Button
    (
        -text => 'I already have an account',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                $CustomerLoginWindow::customer -> deiconify();
                $CustomerLoginWindow::customer -> raise();
                $CustomerLoginWindow::customer -> update();
            },
        -background => 'DeepSkyBlue'
    ) -> pack(-side => 'left', -padx => 5, -pady => 10);

    $main -> Button
    (
        -text => 'Staff Member Login',
        -font => 'Roman 14 bold',
        -command =>
            sub
            {
                $StaffLoginWindow::staff -> deiconify();
                $StaffLoginWindow::staff -> raise();
                $StaffLoginWindow::staff -> update();
            },
        -background => 'goldenrod2'
    ) -> pack(-side => 'left', -pady => 10);

    MainLoop();
}
1;
