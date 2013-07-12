difference() {
  cylinder(h=15, r1=5.5, r2=5.5, center=true);
  cylinder(h=17, r1=1.6, r2=1.6, center=true);

  translate([0, 0, 5])
  cylinder(h=10, r1=1.6, r2=3.6, center=true);
}