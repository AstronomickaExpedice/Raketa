

module ring(radius, width, height) {
	difference () {
		cylinder(r = radius, h = height);
		translate([0, 0, -1])
		cylinder(r = radius - width, h = height + 2);
	}
}


module ccube(width, depth, height, z_center = false) {
	if (z_center) {
		translate([-width / 2, -depth / 2, -height / 2])
		cube([width, depth, height]);
	} else {
		translate([-width / 2, -depth / 2, 0])
		cube([width, depth, height]);
	}
}


ccube(100, 100, 10);
ring(50, 5, 20);
ring(50, 2, 30);