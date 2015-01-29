
function sq(x) = x * x;


module ogive(height, width, slices = 10, thickness = -1) {
    radius = (height * height + width * width) / (2 * width);
    
    center_x = -radius + width;
    center_y = 0;
    
    d = height / slices;
    
    echo("radius = ", radius);
    echo("d = ", d);
    
    function w(y, r) = center_x + sqrt(
        (r * r) - (y * y)
    );
    
    difference () {
        polygon(
            points = concat([
                [0, height],
                [0, 0],
                [width, 0]
            ],
            [ for (i = [0 : (slices - 1)]) [w(i * d, radius), i * d] ]),
            paths = [ [ for (i = [0 : (slices + 2)]) i ] ]
        );
        
        if (thickness > 0) {
            polygon(
                points = concat([
                    [0, sqrt(sq(radius - thickness) - sq(radius - width))],
                    [0, 0],
                    [width - thickness, 0]
                ],
                [ for (i = [0 : (slices - 1)]) [w(i * d, radius - thickness), i * d] ]),
                paths = [ [ for (i = [0 : (slices + 2)]) i ] ]
            );
        }
    }
}


module ogive_nose_cone(radius, height, slices = 10, thickness = -1) {
    rotate_extrude ($fn = slices)
    ogive(height, radius, slices = slices, thickness = thickness);
}


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

module twisted_ribs(outer_r, inner_r, height, twist, count, wall) {
	angle = 360 / count;
	linear_extrude(height, twist = twist, slices = 20) {
		for (i = [0 : (count - 1)]) {
			rotate([0, 0, i * angle])
			translate([0, inner_r])
			square([wall, outer_r - inner_r]);
		}
	}
}

/*
ccube(100, 100, 10);
ring(50, 5, 20);
ring(50, 2, 30);
*/