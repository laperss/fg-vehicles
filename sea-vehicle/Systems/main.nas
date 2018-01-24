var last_time = 0.0;

round10 = func(v) {
	if (v == nil) return 0;
	return 0.1*int(v*10);
}

round100 = func(v) {
	if (v == nil) return 0;
	return 0.01*int(v*100);
}

var update_vars = func( dt ) {
    asl_ft = getprop("/position/altitude-ft");
    ground = getprop("/position/ground-elev-ft");
    agl_m = (asl_ft - ground) * 0.3048;

    setprop("/apm/altitude", round10(agl_m));

    setprop("/apm/pitch",   round10(getprop("/orientation/pitch-deg")));
    setprop("/apm/roll",    round10(getprop("/orientation/roll-deg")));
    setprop("/apm/heading", round10(getprop("/orientation/heading-deg")));

    setprop("/apm/elevator", round100(getprop("/fdm/jsbsim/fcs/elevator-pos-norm"))); 
    setprop("/apm/rudder",   round100(getprop("/fdm/jsbsim/fcs/rudder-pos-norm"))); 
    setprop("/apm/throttle", round100(getprop("/fdm/jsbsim/fcs/throttle-pos-norm")));

    # airspeed-kt is actually in feet per second (FDM NET bug)
    #setprop("/apm/airspeed", round10(0.3048*getprop("/velocities/airspeed-kt")));
    # mps
    setprop("/apm/airspeed", round10(0.514444*getprop("/velocities/airspeed-kt")));
}


var main_function = func {
    var time = getprop("/sim/time/elapsed-sec");
    var dt = time - last_time;
    last_time = time;
    dt = math.mod(systime(), 86400);
    setprop("/position/timetoday", dt);
    positioning.update_position();
    update_vars(dt);
    
    settimer(main_function, 0);
}

setlistener("/sim/signals/fdm-initialized",
    func {
        main_function();
    });
