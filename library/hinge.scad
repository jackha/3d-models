// What diameter or thickness should the hinge have (in 0.01 mm units)?
//hinge_dia = 1000; // [1:5000]  default 635

// How much gap should be left between separate parts (in 0.01 mm units)?
//hinge_gap = 80; // [1:2000]  default 40

epsilon = 0.00001;  // Used to prevent manifold problems

hinge_start = 0.40;  // default 0.25
hinge_end = 1.25-hinge_start;

module hingepair(x0_extra=0, x1_extra=0) {
	union() {
		translate([0,0,-x0_extra]) cylinder(h=hinge_start+x0_extra, r=0.5);
		translate([0,0,hinge_start-epsilon]) cylinder(h=0.25, r1=0.5, r2=0.25);
		translate([0,0,1.25-hinge_start+epsilon]) cylinder(h=0.25, r1=0.25, r2=0.5);
		translate([0,0,1.5-hinge_start]) cylinder(h=hinge_start+x1_extra, r=0.5);
	}
}

/*module hingepair(x0_extra=0, x1_extra=0) {
	union() {
		translate([0,0,-x0_extra]) cylinder(h=0.25+x0_extra, r=0.5);
		translate([0,0,0.25-epsilon]) cylinder(h=0.25, r1=0.5, r2=0.25);
		translate([0,0,1+epsilon]) cylinder(h=0.25, r1=0.25, r2=0.5);
		translate([0,0,1.25]) cylinder(h=0.25+x1_extra, r=0.5);
	}
}*/

module hingecore(gap, x0_extra=0, x1_extra=0) {
	union() {
		difference() {
			union() {
				cylinder(h=1.5, r=0.5);
				translate([0,0,hinge_start+gap])
					cube(size=[0.5,1,1.5-2*hinge_start-gap-gap]);  // connect bottom
				translate([0,-0.5,hinge_start+gap])
					cube(size=[0.5,0.5,1.5-2*hinge_start-gap-gap]); // make bottom square
			}
			translate([0,0,hinge_start+gap-0.5]) cylinder(h=0.75, r1=1, r2=0.25);
			translate([0,0,hinge_end-gap]) cylinder(h=0.75, r1=0.25, r2=1);
		}
		translate([0,0.5+gap,-x0_extra])
			cube(size=[0.5,0.5-gap,1.5+x0_extra+x1_extra]);
	}
}
/*module hingecore(gap, x0_extra=0, x1_extra=0) {
	union() {
		difference() {
			union() {
				cylinder(h=1.5, r=0.5);
				//translate([-0.5,0,0.25+gap])
				//	cube(size=[1,1,1-gap-gap]);
				translate([0,0,0.25+gap])
					cube(size=[0.5,1,1-gap-gap]);  // connect bottom
				translate([0,-0.5,0.25+gap])
					cube(size=[0.5,0.5,1-gap-gap]); // make bottom square
			}
			translate([0,0,0.25+gap-0.5]) cylinder(h=0.75, r1=1, r2=0.25);
			translate([0,0,1-gap]) cylinder(h=0.75, r1=0.25, r2=1);
		}
		//translate([-0.5,0.5+gap,0])
		//	cube(size=[1,0.5-gap,1.5]);
		translate([0,0.5+gap,-x0_extra])
			cube(size=[0.5,0.5-gap,1.5+x0_extra+x1_extra]);
	}
}*/

module hingeedge(gap, x0_extra=0, x1_extra=0) {
	union() {
		hingepair(x0_extra, x1_extra);
		translate([0,-1,-x0_extra])
			cube(size=[0.5,0.5-gap,1.5+x0_extra+x1_extra]);
		translate([0,-1,-x0_extra])
			cube(size=[0.5,1,hinge_start+x0_extra]);
		translate([0,-1,1.5-hinge_start])
			cube(size=[0.5,1,hinge_start+x1_extra]);
		translate([0,0,1.5-hinge_start])
			cube(size=[0.5,0.5,hinge_start+x1_extra]);
		translate([0,0,-x0_extra])
			cube(size=[0.5,0.5,hinge_start+x0_extra]);
	}
}

/*
module hingeedge(gap, x0_extra=0, x1_extra=0) {
	union() {
		hingepair(x0_extra, x1_extra);
		//translate([-0.5,-1,0])
		//	cube(size=[1,0.5-gap,1.5]);
		//translate([-0.5,-1,0])
		//	cube(size=[1,1,0.25]);
		//translate([-0.5,-1,1.25])
		//	cube(size=[1,1,0.25]);
		translate([0,-1,-x0_extra])
			cube(size=[0.5,0.5-gap,1.5+x0_extra+x1_extra]);
		translate([0,-1,-x0_extra])
			cube(size=[0.5,1,0.25+x0_extra]);
		translate([0,-1,1.25])
			cube(size=[0.5,1,0.25+x1_extra]);
		translate([0,0,1.25])
			cube(size=[0.5,0.5,0.25+x1_extra]);
		translate([0,0,-x0_extra])
			cube(size=[0.5,0.5,0.25+x0_extra]);
	}
} */

module single_hinge(thick, realgap, x0_extra=0, x1_extra=0) {
	hingeedge(realgap / thick, x0_extra, x1_extra);
	hingecore(realgap / thick, x0_extra, x1_extra);
}

module hinge(hinge_dia, hinge_gap, amount=1) {
	scale([hinge_dia, hinge_dia, hinge_dia])
	rotate([0,90,0])
	for (a = [0:amount-1]) {
		translate([0,0,a*1.25]) {
			if (amount == 1) {
				single_hinge(hinge_dia, hinge_gap);
			} else if (a == 0) {
				single_hinge(hinge_dia, hinge_gap, x1_extra=epsilon);
			} else if (a == amount-1) {
				single_hinge(hinge_dia, hinge_gap, x0_extra=epsilon);
			} else {
				// middle piece
				single_hinge(hinge_dia, hinge_gap, x0_extra=epsilon, x1=epsilon);
			}
		}
	}
}

// half hinge
module hinge_edge(hinge_dia, hinge_gap, amount=1) {
	scale([hinge_dia, hinge_dia, hinge_dia])
	rotate([0,90,0])
	for (a = [0:amount-1]) {
		translate([0,0,a*1.25]) {
			if (amount == 1) {
				hingeedge(hinge_gap/hinge_dia);
			} else if (a == 0) {
				hingeedge(hinge_gap/hinge_dia, x1_extra=epsilon);
			} else if (a == amount-1) {
				hingeedge(hinge_gap/hinge_dia, x0_extra=epsilon);
			} else {
				// middle piece
				hingeedge(hinge_gap/hinge_dia, x0_extra=epsilon, x1=epsilon);
			}
		}
	}
}

// half hinge
module hinge_core(hinge_dia, hinge_gap, amount=1) {
	scale([hinge_dia, hinge_dia, hinge_dia])
	rotate([0,90,0])
	for (a = [0:amount-1]) {
		translate([0,0,a*1.25]) {
			if (amount == 1) {
				hingecore(hinge_gap/hinge_dia);
			} else if (a == 0) {
				hingecore(hinge_gap/hinge_dia, x1_extra=epsilon);
			} else if (a == amount-1) {
				hingecore(hinge_gap/hinge_dia, x0_extra=epsilon);
			} else {
				// middle piece
				hingecore(hinge_gap/hinge_dia, x0_extra=epsilon, x1=epsilon);
			}
		}
	}
}

module demo(t, rg) {
	scale([t,t,t])
	translate([-2.75,0,0.5])
	rotate(a=[0,90,0])
	union() {
		hinge(t, rg);
		translate([0,0,1.25]) hinge(t, rg);
		translate([0,0,2.5]) hinge(t, rg);
		translate([0,0,3.75]) hinge(t, rg);
		translate([0,1,0]) cube(size=[0.5,2,5.25]);
		translate([0,-3,0]) cube(size=[0.5,2,5.25]);
	}
}

//demo(hinge_dia/100, hinge_gap/100);

/*scale([hinge_dia/100, hinge_dia/100, hinge_dia/100])
rotate([0,90,180])
single_hinge(hinge_dia/100, hinge_gap/100);
*/

// length will be dia*amount*1.25
$fn = 30;
hinge_core(1000/100, 80/100, amount=5);
hinge_edge(1000/100, 80/100, amount=5);
