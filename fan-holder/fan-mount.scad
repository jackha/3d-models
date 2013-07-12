// the holder itself
fan_mount_hole_dia = 4.5;
fan_mount_plate_dia = 10;
fan_mount_distance = 10;
mount_hole_dia = 5;
mount_plate_dia = 16;

module single_mount() {

difference() {
  hull()
  {
    cylinder(r=fan_mount_plate_dia/2,h=5);
	translate([0, fan_mount_distance, 0]) 
      cylinder(r=fan_mount_plate_dia/2,h=5);
	
  }
  translate([0, fan_mount_distance, 0]) 
    cylinder(r=fan_mount_hole_dia/2,h=5);
}

}


single_mount();
translate([50, 0, 0])
  single_mount();
hull() {
	translate([-5, 0, 2.5])
      cube([fan_mount_plate_dia, fan_mount_plate_dia, 5], center=true);
	translate([50, 0, 0])
	  cylinder(r=fan_mount_plate_dia/2,h=5);
}

translate([-5, -5, 0])

rotate([0, -90, 0]) {
difference() {

union() {
cube([mount_plate_dia * 0.5 + 5, mount_plate_dia, 5]);
translate([mount_plate_dia * 0.5 + 5, mount_plate_dia/2, 0]) {
      cylinder(r=mount_plate_dia/2, h=5);
}
}

translate([mount_plate_dia * 0.5 + 5, mount_plate_dia/2, 0]) {
	  translate([0, 0, -1])
        cylinder(r=mount_hole_dia/2, h=7);

}

}
}