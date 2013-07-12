card_length = 87;
card_width = 55; 
height = 12;

head_thickness = 2.5;
side_thickness = 2;
base_thickness = 1.5;

finger_hole_dia = 15;
top_rounding_dia = 8;
corner_rounding_r = 5;

module base() {
	translate([corner_rounding_r, corner_rounding_r, height/2-1])

	minkowski() {

	// object is now 2 mm high
	minkowski() {
	 	cube([card_width-2*corner_rounding_r+side_thickness*2, card_length-2*corner_rounding_r+head_thickness*2, 1]);	    
		cylinder(r=corner_rounding_r, h=1);
	}

	scale([0.5, 1, 1])
	rotate([-90, 0, 0])
	cylinder(r=(height-2)/2, h=1);

	}
}

module inner_cutout() {

difference() {
	translate([1, 1-(head_thickness+1), height-4])
	minkowski() {
		cube([card_width-2, card_length+head_thickness+1, 1]);
		cylinder(r1=1, r2=0, h=1);
	} 

	// fill one part again, why 2.5?? buggy??
	translate([side_thickness, head_thickness+card_length-2.5, 0])
	cube([card_width, head_thickness, height]);
	}

	translate([1, -(head_thickness+1), height-3])
	cube([card_width-2, card_length+head_thickness+1, 5]);

	translate([1.5, 0, base_thickness])
	cube([card_width-3, card_length, height-base_thickness-3]);

}


module part() {
	difference() {
		base();

		translate([side_thickness, head_thickness, base_thickness])
		inner_cutout();
	}
}

union() {
difference() {

// main part
part();

// half cylinder cup
translate([1+side_thickness, head_thickness, base_thickness])
difference() {
minkowski() {
	cube([card_width-2, card_length-1, 1]);

	scale([3/(height-base_thickness-4.5),1,1])
	rotate([-90, 0, 0])
	cylinder(r=(height-base_thickness-4.5), h=1);
}
translate([-500, -500, -1000])
cube([1000, 1000, 1000]);
}

// Finger thing on top
translate([card_width/2+side_thickness, card_length+2*head_thickness+2, height+6])
rotate([90, 0, 0])
cylinder(r=10, h=10);


// Finger holes on bottom
/*translate([card_width/2+side_thickness, 20, -1])
cylinder(r=finger_hole_dia/2, h=10);

translate([card_width/2+side_thickness, (card_length+2*head_thickness)-20, -1])
cylinder(r=finger_hole_dia/2, h=10); */

translate([15, card_length/2+head_thickness, -1])
cylinder(r=finger_hole_dia/2, h=10);

translate([(card_width+2*side_thickness)-15, card_length/2+head_thickness, -1])
cylinder(r=finger_hole_dia/2, h=10);

}

// card stopper
difference() {

translate([card_width/2+side_thickness, 0, height-11])
rotate([-90,0,0])
cylinder(r=10, h=head_thickness);

translate([-500, -500, -1000])
cube([1000, 1000, 1000]);

}

} // union




