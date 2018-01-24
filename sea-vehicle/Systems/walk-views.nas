###############################################################################
##
## Swedish Navy 20m-class motor torpedo boat for FlightGear.
##
##  Copyright (C) 2012 - 2016  Anders Gidenstam  (anders(at)gidenstam.org)
##  This file is licensed under the GPL license v2 or later.
##
###############################################################################

###############################################################################
# Walk views.

# Deck
var deckConstraint = walkview.makeUnionConstraint
   (
    [
     # Bridge area.
     walkview.SlopingYAlignedPlane.new([ 9.40, -1.10, 0.28],
                                       [11.00,  1.10, 0.22]),
     # The areas port and starboard of the engine companion.
     walkview.SlopingYAlignedPlane.new([11.00, -1.00, 0.22],
                                       [12.70, -0.55, 0.18]),
     walkview.SlopingYAlignedPlane.new([12.70, -0.80, 0.18],
                                       [13.70, -0.55, 0.10]),
     walkview.SlopingYAlignedPlane.new([11.00,  0.55, 0.22],
                                       [12.70,  1.00, 0.18]),
     walkview.SlopingYAlignedPlane.new([12.70,  0.55, 0.18],
                                       [13.70,  0.80, 0.10]),
     # The area aft of the engine companion.
     walkview.SlopingYAlignedPlane.new([13.70, -0.70, 0.10],
                                       [14.60,  0.70, 0.08]),
    ]); 

# Create the view managers.
var deck_walker =
        walkview.Walker.new("Deck View",
                            deckConstraint);
#                            [walkview.JSBSimPointmass.new(29)]);

deck_walker.set_eye_height(1.70);

###############################################################################
