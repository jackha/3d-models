wood_thickness = 9;  // base for sizes is the wood thickness

hinge_depth = 30;  // actually the length of the body
hinge_height = wood_thickness * 1.5;  // * 1.0 for just folding or * 1.5 for folding over 
hinge_width = 10;  // thickness
penis_dia = 7;
penis_length = 5;
penis_clearance = 0.4;  // Try this out, see if it fits. 

hole_from_side = 8;
hole_from_bottom = wood_thickness / 2;
hole_dia = 4;
hole_dia_outer = 9;
hole_distance_to_outer = 3;  // distance from outer to narrow part

left_or_right = 1;  // 0 for tapped hole on one side, 1 for other side

module hinge_body() {
	cube([hinge_width, hinge_height, hinge_depth]);

	translate([hinge_width/2,hinge_height,0])
	cylinder(hinge_depth, hinge_width/2, hinge_width/2, [0,0,0]);
}

module hinge_body_holes() {
	difference() {
	   	hinge_body();
		translate([-1, hole_from_bottom, hole_from_side])
			rotate([0,90,0])
				cylinder(hinge_width+2, hole_dia/2, hole_dia/2);
		translate([-1, hole_from_bottom, hinge_depth-hole_from_side])
			rotate([0,90,0])
				cylinder(hinge_width+2, hole_dia/2, hole_dia/2);
	}
}

module hinge_body_tapped_holes1() {
	difference() {
		hinge_body_holes();
		translate([-1, hole_from_bottom, hole_from_side])
			rotate([0,90,0])
				cylinder(hole_distance_to_outer+1, hole_dia_outer/2, hole_dia/2);
		translate([-1, hole_from_bottom, hinge_depth-hole_from_side])
			rotate([0,90,0])
				cylinder(hole_distance_to_outer+1, hole_dia_outer/2, hole_dia/2);
	}
}

module hinge_body_tapped_holes2() {
	difference() {
		hinge_body_holes();
		translate([hinge_width-hole_distance_to_outer, hole_from_bottom, hole_from_side])
			rotate([0,90,0])
				cylinder(hole_distance_to_outer+1, hole_dia/2, hole_dia_outer/2);
		translate([hinge_width-hole_distance_to_outer, hole_from_bottom, hinge_depth-hole_from_side])
			rotate([0,90,0])
				cylinder(hole_distance_to_outer+1, hole_dia/2, hole_dia_outer/2);
	}
}

// male
if (left_or_right == 0) {
    hinge_body_tapped_holes1();
} else {
    hinge_body_tapped_holes2();
}
translate([hinge_width/2,hinge_height,hinge_depth-1])
cylinder(penis_length+1, (penis_dia-penis_clearance)/2, penis_dia/2, [0,0,0]);

// female
translate([2*hinge_width,0,0]) {
	difference() {
		if (left_or_right == 0) {
    			hinge_body_tapped_holes1();
		} else {
    			hinge_body_tapped_holes2();
		}
		translate([hinge_width/2,hinge_height,hinge_depth-penis_length-1])
			cylinder(penis_length+2, penis_dia/2, (penis_dia+penis_clearance)/2, [0,0,0]);
	}
}

