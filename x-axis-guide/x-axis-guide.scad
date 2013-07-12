rotate([180,0,0])

difference() {

minkowski() {
cube([32-1, 19.5-1, 15-1]);
sphere(r=0.5);
}

translate([-22, 5, -5])
cube([32, 19.5, 15]);

translate([5, -1, 5])
rotate([-90, 0, 0])
cylinder(r=1.5, h=10);

translate([25, 12.5, -1])
cylinder(r=4, h=20);

}