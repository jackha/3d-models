// wallet 2 with hinge
use <../library/hinge.scad>


// the case without hinge
card_length = 87;
card_width = 55;
card_width_clearance = 3;  //clearance to right 'wall'
height = 12;

head_thickness = 3;
opening_clearance = 0.3;  // the parts that touch when closed
side_thickness = 2;
base_thickness = 1.2;

corner_rounding_r = 5;

right_thickness_fraction = 0.5;  // divide left and right part
hole_dia = 15;  // big holes

// hinge
hinge_dia = 100*height;  // in 0.01 mm units
hinge_gap = 60;  // in 0.01 mm units
amount = 7;
hinge_length = hinge_dia / 100 * (amount * 1.25 + 0.25); // make it close to 90
echo("hinge_length: ", hinge_length);
hinge_x_width = hinge_dia / 100 / 2;  //the hinge takes so much room
extra_width = hinge_x_width + hinge_gap/100;  // make up for hinge

finger_hole_dia = 15;
finger_hole_y_scale = 0.4;
finger_hole_from_side = 10;

//
wallet_length = card_length + head_thickness * 2;

$fn = 30;


module test_card() {
	cube([card_width, card_length, 1]);
}

module base() {
	translate([corner_rounding_r-height/2, corner_rounding_r, height/2-1])

	minkowski() {

	// object is now 2 mm high
	minkowski() {
	 	cube([card_width-2*corner_rounding_r+side_thickness*2+extra_width+height/2, card_length-2*corner_rounding_r+head_thickness*2-1, 1]);	    
		cylinder(r=corner_rounding_r, h=1);
	}

	scale([0.5, 1, 1])
	rotate([-90, 0, 0])
	cylinder(r=(height-2)/2, h=1);

	}
}

module base_cutaway() {
	difference() {
		base();
		// hinge will start in y axis, from hinge_dia/100/2+hinge_gap/100
		translate([-500+hinge_dia/100/2+hinge_gap/100,0,0])
		cube([1000,1000,1000], center=true);
	}
}

module right_side() {

	difference() {
		intersection() {  // make bottom side rounded as well
		union() {
			scale([1,wallet_length/hinge_length,1])
			rotate([0,0,90])
			translate([0,0,hinge_dia/100/2])
			hinge_edge(hinge_dia/100, hinge_gap/100, amount=amount);
			base_cutaway();

			// make good integration with hinge
			//translate([0,card_length+head_thickness,0])
			//cube([10,head_thickness,height]);
		} //union

		hull() {
			translate([0,0,height/2])
			rotate([-90,0,0])
			cylinder(r=height/2, h=1000);
			translate([200,0,height/2])
			rotate([-90,0,0])
			cylinder(r=height/2, h=1000);
		}

		base();

		} // intersection

		// slice top off
		translate([extra_width,
				-1,right_thickness_fraction*height])
		cube([card_width+card_width_clearance,card_length+2*head_thickness+2,1000]);

		// slice box out. the box can hold cards and money. the boxigy bigger than a card.
		translate([extra_width+card_width_clearance-1,
				head_thickness-0.5,base_thickness])
		cube([card_width+1,card_length+1,1000]);

		// cut some fancy holes
		translate([extra_width+card_width/2, 25, -1])
		cylinder(r=hole_dia/2, h=10);

		translate([extra_width+card_width/2, card_length+head_thickness*2-25, -1])
		cylinder(r=hole_dia/2, h=10);

		// make hinge side less sharp
		/*translate([-hinge_dia/2/100+3, card_length+head_thickness*2+1, 0])
		mirror([1,0,0])
		rotate([90,0,0])
		linear_extrude(height = card_length+head_thickness*2+2)
		polygon(points=[[0,-0.1],[3,3],[3,-0.1]], paths=[[0,1,2]]);*/

		// finger "holes"
		translate([extra_width+card_width-finger_hole_from_side,1,height/2])
		rotate([90,0,0])
		scale([1,finger_hole_y_scale,1])
		cylinder(r=finger_hole_dia/2, h=10);

		translate([extra_width+card_width-finger_hole_from_side,card_length+2*head_thickness-1,height/2])
		rotate([-90,0,0])
		scale([1,finger_hole_y_scale,1])
		cylinder(r=finger_hole_dia/2, h=10);

	}

	// add tapered edge
	intersection() {
		translate([extra_width+card_width+card_width_clearance,0,height])
		rotate([0,180,0])
		tapered_edge();
		// make sure the edge does not stick out
		base_cutaway();
	}
}

module card_slide_shape() {
	part_height = (1-right_thickness_fraction)*height-base_thickness;
	cylinder(r=0.1, h=part_height+1);
	translate([0,0,part_height-1.5])
		cylinder(r1=1, r2=0.1, h=1);
	cylinder(r=1, h=part_height-1.4);
}

module left_inner() {
	// no exact science here. That gives the cards extra space.
	translate([-card_width-10-extra_width, head_thickness+1, base_thickness])
	minkowski() {
		cube([card_width+10-2, card_length-2, 0.1]);
		card_slide_shape();
	}
}

// Make edge slightly tapered so closing lid will be closed.
module tapered_edge() {
	translate([0,
				 card_length+head_thickness*2+1,0])
	rotate([90,0,0])
	linear_extrude(height = card_length+head_thickness*2+2)
	polygon(points=[[-0.1,-0.1],[-0.1,2],[1.3,-0.1]], 
			paths=[[0,1,2]]);
}

module left_side() {
	edge_thickness = 0.7;
	difference() {
	union() {
	difference() {
		intersection() {
		union() {
			scale([1,wallet_length/hinge_length,1])
			rotate([0,0,90])
			translate([0,0,hinge_dia/100/2])
			hinge_core(hinge_dia/100, hinge_gap/100, amount=amount);

			mirror([1,0,0])
				base_cutaway();
		}  // union

		hull() {
			translate([0,0,height/2])
			rotate([-90,0,0])
			cylinder(r=height/2, h=1000);
			translate([-200,0,height/2])
			rotate([-90,0,0])
			cylinder(r=height/2, h=1000);
		}  // rounding bottom part
		mirror([1,0,0])
		base();

		} // intersection

		// slice top off
		translate([-500-hinge_x_width,-1,500+(1-right_thickness_fraction)*height])
		cube([1000, 1000, 1000], center=true);

		// slice side so cards can get out
		translate([-500-extra_width-card_width-card_width_clearance+opening_clearance, -1, 0])
		cube([1000,1000,1000], center=true);

		left_inner();

		// cut some fancy holes
		translate([-extra_width-card_width/2, 25, -1])
		cylinder(r=hole_dia/2, h=10);

		translate([-extra_width-card_width/2, card_length+head_thickness*2-25, -1])
		cylinder(r=hole_dia/2, h=10);

		// finger "holes"
		translate([-extra_width-card_width+finger_hole_from_side,1,height/2])
		rotate([90,0,0])
		scale([1,finger_hole_y_scale,1])
		cylinder(r=finger_hole_dia/2, h=10);

		translate([-extra_width-card_width+finger_hole_from_side,card_length+2*head_thickness-1,height/2])
		rotate([-90,0,0])
		scale([1,finger_hole_y_scale,1])
		cylinder(r=finger_hole_dia/2, h=10);

	}  // difference

	// add thickness to the edge
	translate([-extra_width-card_width-card_width_clearance+opening_clearance,
				card_length+1+head_thickness,base_thickness])
	rotate([90,0,0])
	linear_extrude(height = card_length+2)
	polygon(points=[[0,-0.1],[0,edge_thickness],[10,0],[10,-0.1]], 
			paths=[[0,1,2,3]]);

	} // union

	//make lower left edge slightly tapered
	translate([-extra_width-card_width-card_width_clearance+opening_clearance,
				 0,0])
	tapered_edge();
	
	// make hinge side less sharp
	/*translate([hinge_dia/2/100-3, card_length+head_thickness*2-1, 0])
	rotate([90,0,0])
	linear_extrude(height = card_length+head_thickness*2+2)
	polygon(points=[[0,-0.1],[3,3],[3,-0.1]], paths=[[0,1,2]]);
	*/
	} // difference
}

/*
module complete_hinge() {
	scale([1,wallet_length/hinge_length,1])
	rotate([0,0,90])
	translate([0,0,hinge_dia/100/2])
	hinge(hinge_dia/100, hinge_gap/100, amount=amount);
}

complete_hinge();
*/

right_side();
left_side();
//translate([0,0,30])
//	test_card();