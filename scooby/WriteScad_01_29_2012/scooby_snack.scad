use <Write.scad>

$fn=50;
bone_dia = 35;
height = 5;

module bone() {
for (y = [-1, 1]) {
for (x = [-1, 1]) {
translate([x * bone_dia * 0.5 * 1.6, y * bone_dia * 0.4, 0])
cylinder(r=bone_dia/2, h=height);
}
}
translate([0, 0, height/2])
cube([1.5*bone_dia, bone_dia, height], center=true);
}

difference() {
	bone();

scale([1.5, 1.2, 1]) {
translate([0, 4, height/2-1])
write("SCOOBY",t=height+4, h=10, center=true, font="knewave.dxf");

translate([0, -6, height/2-1])
write("SNACK",t=height+4, h=10, center=true, font="knewave.dxf");
}

translate([0, 13, -1])
cylinder(r=2.5, h=10);

}