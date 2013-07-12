// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

mirror([1,0,0]) {

difference() {

union() {

translate([0, -10, 0])
minkowski()
{
   cube([20,30,19]);
   cylinder(r=4,h=1);
}


difference() {
  hull()
  {
    translate([12.5, 12.5, 0])
    cylinder(r=15,h=5);
    translate([20, 40, 0])
    cylinder(r=15,h=5);
  }
  translate([20, 40, -1])
  cylinder(r=4,h=6);
}
}

   translate([0, 0, -1])
   cube([20,20,22]);

   translate([1.5, -16, -1])
   cube([17,20,22]);


// screw holes

translate([-4,-7.5,10])
rotate(a=90, v=[0,1,0])
hexagon(5.5, 3);

translate([23,-7.5,10])
rotate(a=90, v=[0,1,0])
cylinder(r2=3, r1=1.5, h=3);

translate([-10,-7.5,10])
rotate(a=90, v=[0,1,0])
cylinder(r=1.5, h=40);

}

}