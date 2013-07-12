module base() {
	// Base plate
	cube([100,100,5]);

	// Big triangle
	linear_extrude(height = 100)
	polygon(points=[[0,0],[70,0],[0,70]], paths=[[0,1,2]]);

	// Side mount
	cube([5, 100, 100]);
	cube([100, 5, 100]);

	// Leg but bigger
	translate([0, 0, 46])
	cube([45, 45, 100-46]);
}


difference() {
	base(); 

	// Triangle
	translate([-0.1, -0.1, -0.1])
	linear_extrude(height = 47)
	polygon(points=[[0,0],[48,0],[0,48]], paths=[[0,1,2]]);

	// Uitsparing voor poot
	translate([-0.1, -0.1, 46])
	cube([40,40,100]);

	// Dunner maken uitsparing poot
	translate([45, 5, 46])
	cube([100,100,100]);

	translate([5, 45, 46])
	cube([100,100,100]);

	// Gat voor grote moer
	translate([0, 0, 28.5])
	rotate([-90, 0, -45])
	cylinder(r=4, h=100);
}

// Extra support
translate([40, 40, 0])
cube([5, 60, 100]);