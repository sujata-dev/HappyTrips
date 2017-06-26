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



=begin

🛦🛧🛨🛩🛪🛫🛬
$main->Label(-text => 'Customer Login', -background =>'DarkSlateGray', -font => 'Helvetica 13 bold', )->pack(-side => 'top')->place(-x=>800,-y=>250);

#inconvenience is regretted
#Airline reservation system contains airline schedules, fare tariffs, passenger reservations and ticket records. The second type of direct distribution channel are consumers who use the internet or mobile applications to make their own reservations.

#An airline’s inventory contains all flights with their available seats. The inventory of an airline is generally divided into service classes (e.g. first, business or economy class) and up to 26 booking classes, for which different prices and booking conditions apply. Inventory control steers how many seats are available in the different booking classes, by opening and closing individual booking classes for sale. In combination with the fares and booking conditions stored in the Fare Quote System, the price for each sold seat is determined.
#IndiGo (39.6%)
#Jet Airways, Air India, SpiceJet, GoAir, Vistara
# create bookings, change bookings or terminate a particular booking.
=cut

