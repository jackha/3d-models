width = 15;
outer_hole_dia = 5;
expanded_part_width = 16;

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module holder() {


difference() {

union() {

translate([0, -9, 0])
minkowski()
{
   cube([20,29,width-1]);
   cylinder(r=3,h=1);
}


difference() {
  hull()
  {
    translate([10, 12.5, 0])
    cylinder(r=expanded_part_width/2,h=5);
    translate([10, 50, 0])
    cylinder(r=expanded_part_width/2,h=5);
  }

  translate([10, 50, -1])
  cylinder(r=outer_hole_dia/2,h=7);
}
}

// hole for main extrusion
   translate([0, 0, -1])
   cube([20,20,22]);

// for screw part
   translate([1.5, -16, -1])
   cube([17,20,22]);


// screw holes

translate([-4,-7.5, width/2])
rotate(a=90, v=[0,1,0])
hexagon(5.7, 3);

translate([23,-7.5, width/2])
rotate(a=90, v=[0,1,0])
cylinder(r2=3, r1=1.5, h=3);

translate([-10,-7.5, width/2])
rotate(a=90, v=[0,1,0])
cylinder(r=1.5, h=40);

}

}

holder();
