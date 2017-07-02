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
use StaffWindow;
use CustomerRegistrationSuccess;
use CustomerRegistrationFailure;



StaffLoginWindow::StaffLoginWindow();
StaffWindow::StaffWindow();
BookFlight::BookFlight();
UserWindow::UserWindow();
CustomerLoginWindow::CustomerLoginWindow();
CustomerRegistrationFailure::CustomerRegistrationFailure();
CustomerRegistrationSuccess::CustomerRegistrationSuccess();
SignUpWindow::SignUpWindow();

