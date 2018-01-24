# This script is used to compute the vehicle's position in a local coordinate system. 
# The coordinate system is defined in the properties:
#  /position/ref-origin-lat
#  /position/ref-origin-lon
#  /position/ref-heading
# The local position is published to:
#  position/posx
#  position/posy

var ORIGIN = geo.Coord.new();
ORIGIN.set_latlon(0, 0);

# If there is a predefined "origin", use this. 
if (getprop("/position/ref-origin-lat") and getprop("/position/ref-origin-lon")){
    var lat = getprop("/position/ref-origin-lat");
    var lon = getprop("/position/ref-origin-lon");
    ORIGIN.set_latlon(lat, lon);

} else {
    ORIGIN.set_latlon(42.37824878120545, -71.00457885362507);
}

# If there is a predefined "heading", use this. 
if (getprop("/position/ref-heading")){
    var RUNWAY_HEADING = getprop("/position/ref-heading");
} else {
    var RUNWAY_HEADING = 199.67;
}

var update_position = func {
    position = geo.aircraft_position();
    var course = ORIGIN.course_to(position)-RUNWAY_HEADING;
    var distance = ORIGIN.distance_to(position);
    var direct_distance = ORIGIN.direct_distance_to(position);

    var x = math.cos(D2R*course)*distance;
    var y = math.sin(D2R*course)*distance;

    setprop("position/distance-origin", distance);
    setprop("position/course-origin", course);
    setprop("position/posx", x);
    setprop("position/posy", y);
}
