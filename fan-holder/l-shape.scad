// L-shaped mounting plate
mount_hole_dia = 5.5;
mount_plate_dia = 16;

module part() {
difference() {
	hull() {
		translate([mount_plate_dia/2, 0, 2.5])
      		cube([mount_plate_dia, mount_plate_dia, 5], center=true);
		translate([15, 0, 0])
	  		cylinder(r=mount_plate_dia/2,h=5);
	}

	translate([15, 0, -1])
	  cylinder(r=mount_hole_dia/2,h=7);
}

}



part();

translate([5, 0, 0])
	rotate([0, -90, 0])
  		part();