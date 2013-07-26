// JH logo

thickness = 5;
size = 50;  // total height

module logo_base(thickness, size, radius, line_thickness)
{
	arrow_pos = 0.6;

	//line_thickness = size * 0.15;
	hor_line_thickness = line_thickness;
	//radius = size * 0.25 + line_thickness / 2 / 2;
	
	translate([radius, radius, 0])
	cylinder(r=radius, h=thickness);

	translate([radius, radius, 0])
	cube([radius, radius, thickness]);

	// Horizontal line
	translate([2*radius - 1, 2*radius - line_thickness, 0])
	cube([size * arrow_pos + 1, line_thickness, thickness]);

	// triangle
	/*translate([2*radius + size*arrow_pos, size/2-1.5*line_thickness, 0])
	linear_extrude(height = thickness)
	polygon(points=[[0,0],[2*line_thickness, 1.5*line_thickness],[0,3*line_thickness]], paths=[[0,1,2]]);
	*/

	// Top part of J
	translate([2*radius - hor_line_thickness, 2*radius - 1, 0])
	cube([hor_line_thickness, size - (2*radius) + 1, thickness]);

	// Right part of H
	translate([2*radius + size*0.2, 0, 0])
	cube([hor_line_thickness, size, thickness]);
}

module logo(thickness, size)
{
	line_thickness = size * 0.18;
	radius = size * 0.25 + line_thickness / 2 / 2;
	inner_radius = radius - line_thickness;
	difference() {
		logo_base(thickness, size, radius, line_thickness);
		translate([radius, radius, -1])
			cylinder(r=inner_radius, h=thickness+2);
		translate([radius, radius, -1])
			cube([inner_radius, inner_radius, thickness+2]);
	}
}

minkowski()
{
	logo(thickness, size);
	//sphere(r=3);
}