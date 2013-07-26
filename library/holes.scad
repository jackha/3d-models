// holes

module tapped_hole(r1, r2, h1, h2) {
   // make some kind of a funnell
	// for use with screws
	// it is on purpose a little bit bigger than advertised. it is used for subtraction

	translate([0, 0, -1])
	cylinder(r=r1, h=h1+2);
	translate([0, 0, h1])
	cylinder(r1=r1, r2=r2, h=h2+0.1);
}

tapped_hole(r1=1.5, r2=5, h1=10, h2=3);