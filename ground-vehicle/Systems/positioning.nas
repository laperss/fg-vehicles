var ORIGIN = geo.Coord.new();
var RUNWAY_HEADING = 199.67;
ORIGIN.set_latlon(42.37824878120545, -71.00457885362507);

var update_position = func {
    position = geo.aircraft_position();
    var course = ORIGIN.course_to(position)-RUNWAY_HEADING;
    var distance = ORIGIN.distance_to(position);

    var x = math.cos(D2R*course)*distance;
    var y = math.sin(D2R*course)*distance;

    setprop("position/distance-origin", distance);
    setprop("position/course-origin", course);

    setprop("position/posx", x - 2.3);
    setprop("position/posy", y);
    }