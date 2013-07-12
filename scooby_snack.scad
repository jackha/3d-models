bone_dia = 30;
height = 15;

module bone() {
for (y = [-1, 1]) {
for (x = [-1, 1]) {
translate([x * bone_dia * 0.5 * 1.6, y * bone_dia * 0.45, 0])
cylinder(r=bone_dia/2, h=height);
}
}
translate([0, 0, height/2])
cube([1.5*bone_dia, bone_dia, height], center=true);
}

minkowski() {
	bone();
	sphere(3);
}