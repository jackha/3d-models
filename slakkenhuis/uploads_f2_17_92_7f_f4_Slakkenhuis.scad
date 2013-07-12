
module slakkenhuis() {

	module part(m, n, flr, halfwall, wall, window, rad, beam) {
		r1 = radius_o * pow(radius_f, n / num_parts);
		r2 = radius_o * pow(radius_f, (n + 1) / num_parts);

		x1 = r1;
		y1 = 0;
		x2 = r2 * cos(deg);
		y2 = r2 * sin(deg);
		z1 = (r1 - radius_o) / (radius_o * radius_f - radius_o) * height_s + height_o;
		z2 = (r2 - radius_o) / (radius_o * radius_f - radius_o) * height_s + height_o;

		base = height_s * m;
		rotation = n * 360 / num_parts;

		length = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
		alpha = atan((x1 - x2) / y2);

		floor_l = sqrt(pow(x2, 2) + pow(y2, 2));

		dr = r1 * (1 - radius_f) / 2;

		rotate([0, 0, rotation])
			translate([x1, y1, base])
				rotate([0, 0, alpha])
					union() {
	
						// Floor
						if (flr) {
							translate([- floor_l, 0, 0])
								cube([floor_l, length, floor_w]);
						}

						if (wall) {
							polyhedron(
								points = [
									[0, 0, z1 - base],
									[- width, 0, z1 - base],
									[0, length, z1 - base],
									[- width, length, z1 - base],
									[0, length, z2 - base],
									[- width, length, z2 - base]
								],
								triangles = [
									[0, 1, 4, 5],
									[0, 2, 4],
									[1, 3, 5]
								]
							);

							// Wall with window
							difference() {
								translate([- width, 0, 0])
									cube([width, length, z1 - base]);
								if (window) {
									translate([- 1.5 * width, frame_w, frame_b + floor_w])
										cube([width * 2, length - frame_w * 2, z1 - base - frame_b - frame_w * 2 - floor_w]);
								}
							}
						}
						if (halfwall) {
							// Wall with window
							difference() {
								translate([- width, 0, 0])
									cube([width, length, height_s]);
								if (window) {
									translate([- 1.5 * width, frame_w, frame_b + floor_w])
										cube([width * 2, length - frame_w * 2, height_s - frame_b - frame_w * 2 - floor_w]);
								}
							}
						}

						// Radial wall
						if (rad) {
							translate([- width, 0, floor_w])
								rotate([0, 0, -alpha])
									translate([width - dr * 2 - width / 2, 0, 0])
										cube([dr * 2, width, height_s - floor_w]);
						}

						// Beam
						if (beam) {
							translate([- frame_w, 0, z1 - base - frame_w])
								union() {
									rotate([0, -45, -alpha])
										cube([frame_w, frame_w, sqrt(pow(dr, 2) * 2)]);
									rotate([0, 0, -alpha])
										translate([frame_w - dr * 2, 0, dr - frame_w / 2])
											cube([dr, frame_w, frame_w]);
								}
						}
					}
	}

	for (i = [0:num_parts - 5]) {
		color([0, 1, 1])
			part(0, i, true, false, true, true, false, true);
	}

	for (i = [num_parts - 4:num_parts - 3]) {
		color([0, 1, 1])
			part(0, i, true, true, false, true, false, true);
		color([0, 1, 0])
			part(1, i, true, false, true, false, false, true);
	}

	for (i = [num_parts - 2:num_parts - 1]) {
		color([0, 1, 1])
			part(0, i, true, true, false, false, false, true);
		color([0, 1, 0])
			part(1, i, true, false, true, true, false, true);
	}

	for (i = [num_parts:num_parts + 1]) {
		color([0, 1, 1])
			part(0, i, false, true, false, false, false, true);
		color([0, 1, 0])
			part(1, i, false, false, true, true, false, true);
		color([0, 1, 0])
			part(1, i + num_parts, true, true, false, false, false, false);
	}

	for (i = [num_parts + 2:num_parts + 3]) {
		color([0, 1, 0])
			part(1, i, true, false, true, false, false, true);
	}

	for (i = [num_parts + 4:num_parts * 2 - 5]) {
		color([0, 1, 0])
			part(1, i, true, true, false, false, false, true);
		color([1, 1, 0])
			part(2, i, true, false, true, false, false, true);
	}

	for (i = [num_parts * 2 - 4:num_parts * 2 - 1]) {
		color([0, 1, 0])
			part(1, i, true, false, false, false, false, false);
		color([1, 1, 0])
			part(2, i, true, false, true, false, false, true);
	}

	color([0, 1, 1])
		part(0, num_parts * 2, false, true, false, false, false, false);

	color([0, 1, 1])
		part(0, num_parts * 2 + 1, false, true, false, false, false, false);

	color([0, 1, 0])
		part(1, num_parts * 2 + 3, false, true, false, false, false, false);

	color([0, 1, 1])
		part(0, num_parts * 3 - 2, false, true, false, false, false, false);

	color([0, 1, 1])
		part(0, num_parts * 3 - 1, false, true, false, false, false, false);

	for (i = [num_parts * 2:num_parts * 3 - 9]) {
		color([1, 1, 0])
			part(2, i, true, false, true, false, false, true);
	}

	for (i = [num_parts * 3 - 8:num_parts * 4 - 9]) {
		color([1, 0.5, 0])
			part(2.5, i, false, false, true, false, false, true);
	}

	for (i = [num_parts * 4 - 8:num_parts * 5 - 5]) {
		color([1, 0, 0])
			part(3, i, true, false, false, false, false, false);
	}

	// Radial walls
	color([0.9, 0.9, 0.9])
		union() {
			part(0, 2, false, false, false, false, true, false);
			part(1, num_parts - 4, false, false, false, false, true, false);
			part(0, num_parts - 2, false, false, false, false, true, false);
			part(1, num_parts, false, false, false, false, true, false);
			part(0, num_parts + 2, false, false, false, false, true, false);
			part(1, num_parts + 4, false, false, false, false, true, false);
			part(0, num_parts * 2 - 2, false, false, false, false, true, false);
			part(0, num_parts * 2, false, false, false, false, true, false);
		}

	radius_o = 800;
	radius_f = 500 / radius_o;

	height_o = 250;
	height_s = 270;

	width = 30;
	floor_w = 30;
	frame_w = 15;
	frame_b = 100;

	num_parts = 12;
	num_floors = 1;

	deg = 360 / num_parts;
}

translate([0, 0, -400])
	union() {
		slakkenhuis();
		color([0.75, 0.75, 0.75])
			translate([0, 0, 270])
				cylinder(r = 25, h = 2 * 270, center = true);
	}
