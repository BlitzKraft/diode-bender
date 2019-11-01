$fn = 50;
/* diode */
module diode() {
	color("red")
	cylinder(r=1.1, h=4.1, center=true);
	color("black")
	cube([0.5, 0.5, 60], center=true);
}

/* sword */
module sword() {
	/* approxmiate width required between bends
	corresponds to separation between the pcb holes
	*/
	cube_width = 7;
	// Total length, without the pointy extensions
	length = 20;
	difference() {
		union() {
			cube([cube_width, length, 10]);
			// pointy extensions, disregarded in favour of serrations.
			/*
			translate([0, 0, 5]) rotate([0, 90, 0]) rotate([0, 0, 30])
			cylinder(r=5.7735, h=7, $fn=6);
			translate([0, length-1, 5]) rotate([0, 90, 0]) rotate([0, 0, 30])
			cylinder(r=5.7735, h=7, $fn=6);
			*/
			translate([0, 0, 7])
			scale([1, 1, 1.5]) {
				translate([7, 10, 0])
				rotate([90, 0, 0])
				difference() {
					cylinder(r=2, h=20, center=true);
					cube([10, 10, 0.5], center=true);
				}
				translate([0, 10, 0])
				rotate([90, 0, 0])
				difference() {
					cylinder(r=2, h=20, center=true);
					cube([10, 10, 0.5], center=true);
				}
			}
		}
		union() {
			translate([cube_width/2, length/2, 10])
			rotate([0, 90, 0])
			diode();
		}
	}
}

//negative serrations
module serrations() {
	ridges = 30;
	for (count = [0:1:ridges]) {
		translate([0, 1* count, 0])
		cylinder(r=1, h=30, center=true, $fn=3);
	}
}

/* sheath */
module sheath() {
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
}

difference() {
	sword();
	union() {
		rotate([0, 45, 0])
		translate([15, 0, 0])
		rotate([0, 0, 90])
		serrations();
		// uncomment this block for knurls
		/* 
		rotate([0, 90, 0])
		rotate([0, 0, 90])
		serrations();
		*/
		// length - length value from above
		rotate([0, 45, 0])
		translate([0, 20, 0])
		mirror([0, 1, 0])
		translate([15, 0, 0])
		rotate([0, 0, 90])
		serrations();
		translate([1.2, 1.5, 2])
		scale([0.7, 0.65, 1])
		color("red")
		rotate([0, -180, 0])
		rotate([0, 0, 90])
		linear_extrude(height=30) {
			import("BlitzKraft.svg");
		}
	}
}



