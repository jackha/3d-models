// wallet 2 with hinge
use <../library/hinge.scad>
use <../library/logo.scad>
use <../library/WriteScad/Write.scad>
use <voronoi.scad>

// the case without hinge
card_length = 87+3;  // 3 is "card extra", small extra wall + clearance
card_width = 55;
card_width_clearance = 3;  //clearance to right 'wall'
height = 12;

head_thickness = 3;
opening_clearance = 0.5;  // the parts that touch when closed
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
hinge_x_width = hinge_dia / 100 / 2;  //the hinge takes this much room
extra_width = hinge_x_width + hinge_gap/100;  // make up for hinge

finger_hole_dia = 0.7*height;
finger_hole_y_scale = 6;
finger_hole_x_scale = 4/finger_hole_dia;  // make it 2mm

base_rounding_dia = 4;

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

module base_cutaway_except_edge() {
	difference() {
		base();
		// hinge will start in y axis, from hinge_dia/100/2+hinge_gap/100
		difference() {
			translate([-500+hinge_dia/100/2+hinge_gap/100,0,0])
			cube([1000,1000,1000], center=true);

			translate([0,-1,-1])
			cube([1000,head_thickness+1, 1000]);

			translate([0,head_thickness+card_length+opening_clearance,-1])
			cube([1000,head_thickness+1, 1000]);
		}  // difference
	}
}

module base_rounding() {
	rotate([90,0,90])
	hull() {
		translate([base_rounding_dia/2,base_rounding_dia/2,-500])
		cylinder(r=base_rounding_dia/2, h=1000);

		translate([base_rounding_dia/2,height-base_rounding_dia/2,-500])
		cylinder(r=base_rounding_dia/2, h=1000);

		translate([card_length+2*head_thickness-base_rounding_dia/2, base_rounding_dia/2,-500])
		cylinder(r=base_rounding_dia/2, h=1000);

		translate([card_length+2*head_thickness-base_rounding_dia/2,
				height-base_rounding_dia/2,-500])
		cylinder(r=base_rounding_dia/2, h=1000);
	}
}

module closing_lips() {
	translate([-extra_width-card_width-side_thickness-1, head_thickness+0.5, height/4])
	scale([1, 0.7, 1])
	rotate([0,-90,0])
	cylinder(r=1.5, h=1.5);

	translate([-extra_width-card_width-side_thickness-1, head_thickness+card_length-0.5, 
				height/4])
	scale([1, 0.7, 1])
	rotate([0,-90,0])
	cylinder(r=1.5, h=1.5);
}

module right_side() {

	difference() {
		intersection() {  // make bottom side rounded as well
		union() {
			scale([1,wallet_length/hinge_length,1])
			rotate([0,0,90])
			translate([0,0,hinge_dia/100/2])
			hinge_edge(hinge_dia/100, hinge_gap/100, amount=amount);

			base_cutaway_except_edge();

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
		base_rounding();

		} // intersection

		// slice top off
		translate([extra_width,
				head_thickness,right_thickness_fraction*height])
		cube([card_width+card_width_clearance+100,card_length,1000]);

		// slice box out. the box can hold cards and money. the box is slightly bigger than a card.
		translate([extra_width+card_width_clearance-1,
				head_thickness-0.05,base_thickness])
		cube([card_width+1,card_length+0.1,1000]);

		// finger "hole"
		translate([extra_width+card_width+card_width_clearance+side_thickness*2,head_thickness+card_length/2,height/2])
		scale([finger_hole_x_scale,finger_hole_y_scale,1])
		sphere(r=finger_hole_dia/2);

		translate([0,0,height/2])
		rotate([0,180,0])
		translate([0,0,-height/2])
		minkowski() {
			closing_lips();
			//sphere(r=0.2);
			cube([0.2, 0.2, 0.2], center=true);
		}

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
	// "+1.5" is "card extra" beneath for the wall
	translate([-card_width-extra_width-1.5, head_thickness+2+1, base_thickness])
	minkowski() {
		cube([card_width-2, card_length+10-2, 0.1]);
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

		base_rounding();

		} // intersection

		// slice top off
		translate([-500-hinge_x_width,-1,500+(1-right_thickness_fraction)*height])
		cube([1000, 1000, 1000], center=true);

		// slice side so cards can get out
		translate([-500-extra_width+0.1, 500+card_length+head_thickness-opening_clearance, 0])
		cube([1000,1000,1000], center=true);

		// other side
		translate([-500-extra_width+0.1, -500+head_thickness+opening_clearance, 0])
		cube([1000,1000,1000], center=true);

		left_inner();

		// finger "hole"
		translate([-(extra_width+card_width+card_width_clearance+side_thickness*2),head_thickness+card_length/2,height/2])
		scale([finger_hole_x_scale,finger_hole_y_scale,1])
		sphere(r=finger_hole_dia/2);

	} // difference
	closing_lips();
}

$fn = 50;
difference() {
	union() {
		right_side();
		left_side();

		// logo added
		translate([(extra_width+side_thickness)/2+card_width/2,1.5,2])
		rotate([90,0,0]) 
		logo(2, height-4);

	}

	// logo carved out
	translate([(extra_width+side_thickness)/2+card_width/2+height*0.5,card_length+2*head_thickness-0.5,2])
	rotate([90,0,180]) 
	logo(2, height-4);

	// hole to push cards out.
	translate([extra_width+8+5, head_thickness+card_length/2,-1])
	cylinder(r=8, h=10);

	// make a nice voronoi pattern on it.
	translate([-extra_width-5, head_thickness+5.5,0])
	mirror([1,0,0])
	pattern();

	// decorative hole
	/*translate([-extra_width-card_width+8+2, head_thickness+card_length-8-10,-1])
	cylinder(r=8, h=10);*/

	/*translate([-extra_width-card_width+15,card_length/2+head_thickness,0])
	mirror([0,1,0])
	rotate([0,0,90])
	scale([1.2,1,1])
	write("Peter",t=9, h=10, center=true, font="letters.dxf");
*/

}



//base_rounding();

//translate([0,0,30])
//	test_card();
