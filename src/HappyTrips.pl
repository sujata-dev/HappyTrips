#!/usr/bin/perl

package HappyTrips;

use strict;
use warnings;
use DBI;
use Tk;

use SignUpWindow;
use BookFlight;
use UserWindow;
use CustomerLoginWindow;
use StaffLoginWindow;
use CustomerRegistrationSuccess;
use CustomerRegistrationFailure;



StaffLoginWindow::StaffLoginWindow();
BookFlight::BookFlight();
UserWindow::UserWindow();
CustomerLoginWindow::CustomerLoginWindow();
CustomerRegistrationFailure::CustomerRegistrationFailure();
CustomerRegistrationSuccess::CustomerRegistrationSuccess();
SignUpWindow::SignUpWindow();
