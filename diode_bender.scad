$fn = 50;
/* diode */
module diode() {
	color("red")
	cylinder(r=1.1, h=4.1, center=true);
	color("black")
	cylinder(r= 0.29, h = 60, center=true);
}

/* sword */
difference() {
	union() {
		cube([6.5, 11, 10]);
		// teeth on the side
		translate([-1, 0, 0])
		cube([8.5, 1, 10]);
		// side handles
		translate([0, 0, 5]) rotate([0, 90, 0]) rotate([0, 0, 30])
		cylinder(r=5.7735, h=6.5, $fn=6);
		translate([0, 10, 5]) rotate([0, 90, 0]) rotate([0, 0, 30])
		cylinder(r=5.7735, h=6.5, $fn=6);
	}
	union() {
		translate([3.25, 5, 10])
		rotate([0, 90, 0])
		diode();
		translate([6.5, 5, 20])
		diode();
		translate([0, 5, 20])
		diode();
	}
}


/* sheath */
// rotate is for orienting the 3D print. 
//rotate([0, 180, 0])
//translate([0, 0, 20])
%difference() {
	translate([-5, 0, 0])
	cube([16.5, 11, 15]);
	union() {
		translate([-0.5, -5, 0])
		cube([7.5, 20, 10.1]);
		translate([3.25, 5, 10])
		rotate([0, 90, 0])
		diode();
		translate([-1.1, 0, 0])
		cube([8.7, 1, 11]);
	}
}

