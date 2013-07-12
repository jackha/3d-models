wood_thickness = 9;  // base for sizes is the wood thickness

hinge_depth = 30;  // actually the length of the body
hinge_height = wood_thickness * 1.0;  // * 1.0 for just folding or * 1.5 for folding over 
hinge_width = 12;  // thickness
penis_dia = 7;
penis_length = 5;
penis_clearance = 0.4;  // Try this out, see if it fits. 

hole_from_side = hinge_depth / 4;
hole_from_bottom = wood_thickness / 2;
hole_dia = 4;
hole_dia_outer = 8;
hole_distance_to_outer = 3;  // distance from outer to narrow part

left_or_right = 0;  // 0 for tapped hole on one side, 1 for other side
single = 1;

pin_hexagon_size = 7.5;  // moerkop grootte
pin_head_length = hinge_depth; //hinge_depth / 3;  // Ruimte voor moerkop  
pin_length = hinge_depth / 2;  // Hoe lang is de pin in het plastic
pin_dia = 4;

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}


module hinge_body() {
	cube([hinge_height, hinge_depth, hinge_width]);

	translate([hinge_height, 0, hinge_width/2])
	rotate(a=-90, v=[1,0,0])
	cylinder(hinge_depth, hinge_width/2, hinge_width/2, [0,0,0]);
}


module hinge() {
rotate([0, -90, 0]) 
difference() {
	hinge_body();

	// Pin head
	translate([hinge_height, pin_head_length/2 + pin_length, hinge_width/2])
	rotate(a=-90, v=[1,0,0])
	rotate(a=30, v=[0,0,1])
	hexagon(pin_hexagon_size, pin_head_length);

	// Open up
	//translate([hinge_height,pin_length,-1])
	//cube([hinge_height+2, hinge_depth, hinge_width+2]);

	// The actual pin
	translate([hinge_height, -1, hinge_width/2])
	rotate([-90,0,0])
	cylinder(r=pin_dia/2, h=pin_length+2);

	// Screw holes
	translate([hole_from_bottom, hole_from_side, -1])
	cylinder(r=hole_dia/2, h=hinge_depth+2);

	translate([hole_from_bottom, hinge_depth - hole_from_side, -1])
	cylinder(r=hole_dia/2, h=hinge_depth+2);

	// Make screw holes tapped
	translate([hole_from_bottom, hole_from_side, hinge_width-hole_distance_to_outer+0.1])
	cylinder(hole_distance_to_outer, hole_dia/2, hole_dia_outer/2);
	translate([hole_from_bottom, hinge_depth - hole_from_side, hinge_width-hole_distance_to_outer+0.1])
	cylinder(hole_distance_to_outer, hole_dia/2, hole_dia_outer/2);
}
}

if (left_or_right == 0) {
  hinge();

if (single == 0) {
translate([2*hinge_width,0,0])
  hinge();
}

} else {

translate([-hinge_width,0,0])
mirror([ 1, 0, 0 ]) {hinge(); }

if (single == 0) {
translate([hinge_width,0,0])
mirror([ 1, 0, 0 ]) {hinge(); }
}

}