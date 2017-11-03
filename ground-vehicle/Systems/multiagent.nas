var NUM = 10;					# number of tunnel markers
var DIST = 200;				    # distance between markers

var MARKER = "Models/Geometry/hoop.xml";	# tunnel marker
var tunnel = [];
setsize(tunnel, NUM);

var calculate_distance = func() {
    var x = getprop("/position/posx");
    var y = getprop("/position/posy");
    var x_other = getprop("/ai/models/multiplayer/sim/multiplay/generic/float[0]");
    var y_other = getprop("/ai/models/multiplayer/sim/multiplay/generic/float[1]");

    var deltax = x - x_other;
    var deltay = y - y_other;

    #setprop("/ai/models/multiplayer/sim/multiplay/generic/float[2]", deltax);
    #setprop("/ai/models/multiplayer/sim/multiplay/generic/float[3]", deltay);
    
    #setprop("/position/deltax", deltax);
    #setprop("/position/deltay", deltay);
    setprop("/position/systime", systime());
    settimer(calculate_distance, 0);

}

current_players =  getprop("/ai/models/num-players");

var multiplayer = func {
    n_players =  getprop("/ai/models/num-players");
    print("Multiplayer was called: ", n_players);
    if (n_players > current_players){
        print("Player was added!");
        calculate_distance()
        
    }
    else if (n_players < current_players){
        print("Player was removed!");
    }
    current_players = n_players;

    #draw_tunnel_loop()
};

setlistener("/ai/models/num-players", multiplayer);
