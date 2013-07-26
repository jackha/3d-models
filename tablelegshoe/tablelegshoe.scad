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


/*
module inner_support() {
	linear_extrude(height = 5)
	polygon(points=[[30,0],[30,30],[0,70],[0,100],[5,100],[60,5],[60,0]], paths=[[0,1,2,3,4,5,6]]);
}

// Extra support
translate([40, 45, 0])
rotate([90,0,0])
inner_support();

translate([40, 40, 0])
rotate([90,0,90])
inner_support(); 

*/

module small_inner_support() {
	linear_extrude(height = 20)
	polygon(points=[[0,0],[20,20],[20,0]], paths=[[0,1,2]]);
}


module main_part() {

difference() {
union() {
difference() {
	base(); 

	// Triangle
	translate([-0.1, -0.1, -0.1])
	linear_extrude(height = 47)
	polygon(points=[[0,0],[45,0],[0,45]], paths=[[0,1,2]]);

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


}  // union

intersection() {
// small inner support for making print possible
translate([26, 45, 45.9])
rotate([90,0,0])
small_inner_support();

translate([26, 26, 45.9])
rotate([90,0,90])
small_inner_support();

}

// screw holes leg x face
translate([20,38,90])
rotate([-90,0,0])
cylinder(r=2, h=10);

translate([20,38,60])
rotate([-90,0,0])
cylinder(r=2, h=10);

// screw holes leg y face
translate([38,20,90])
rotate([-90,0,-90])
cylinder(r=2, h=10);

translate([38,20,60])
rotate([-90,0,-90])
cylinder(r=2, h=10);

// base plate screw holes
translate([20, 90,-1])
cylinder(r=2, h=10);

translate([20, 75,-1])
cylinder(r=2, h=10);

translate([90, 20,-1])
cylinder(r=2, h=10);

translate([75, 20, -1])
cylinder(r=2, h=10);

translate([90, 90,-1])
cylinder(r=2, h=10);

translate([35, 50,-1])
cylinder(r=2, h=10);

translate([50, 35,-1])
cylinder(r=2, h=10);

// base plate sides
translate([80, -1, 28.5])
rotate([-90,0,0])
cylinder(r=2, h=10);

translate([-1, 80, 28.5])
rotate([-90,0,-90])
cylinder(r=2, h=10);

// take out some ugly corners
translate([100,0,120])
rotate([-90,45,0])
cube([100,100,12], center=true);

translate([0,100,120])
rotate([-90,45,90])
cube([100,100,12], center=true);

} // difference

}

module side_part() {
difference() {
union() {

translate([45,34.9,5])
cube([55, 5, 95]);

translate([50,5,5])
cube([50,30,5]);

translate([45,5,50])
cube([5,30,50]);

translate([45,24,40])
linear_extrude(height = 60)
polygon(points=[[0,0],[0,15],[15,15]], paths=[[0,1,2]]);

translate([100,24,5])
rotate([0,-90,0])
linear_extrude(height = 50)
polygon(points=[[0,0],[0,15],[15,15]], paths=[[0,1,2]]);

}  // union

// make space for the big bolt
translate([44,41,4])
rotate([90,0,0])
cube([10, 40, 70]);

// base plate holes
translate([90, 20,-1])
cylinder(r=2, h=20);

translate([75, 20, -1])
cylinder(r=2, h=20);

// screw holes leg y face
translate([38,20,90])
rotate([-90,0,-90])
cylinder(r=2, h=20);

translate([38,20,60])
rotate([-90,0,-90])
cylinder(r=2, h=20);

// take out some ugly corners
translate([100,0,120])
rotate([-90,45,0])
cube([100,100,100], center=true);

// subtract main part because of some corners
main_part();
}

}

main_part();
//side_part();

// L
/*
translate([-70,0,0])
rotate([-90,0,0])
side_part();
*/

// R
/*
mirror([1,0,0])
rotate([-90,0,0])
side_part();
*/