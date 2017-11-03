var main_loop = func {
    update_position();
    update_vars();
    settimer(main_loop, 0);
}


setlistener("/sim/signals/fdm-initialized",
	    func {
		main_loop();
	    });


round10 = func(v) {
	if (v == nil) return 0;
	return 0.1*int(v*10);
}


var update_vars = func() {
    asl_ft = getprop("/position/altitude-ft");
    ground = getprop("/position/ground-elev-ft");
    agl_m = (asl_ft - ground) * 0.3048;
    
    dt = math.mod(systime(), 86400);
    setprop("/position/timetoday", dt);

    setprop("/apm/altitude", round10(agl_m));
    setprop("/apm/airspeed", round10(0.514444*getprop("/velocities/airspeed-kt")));
}
