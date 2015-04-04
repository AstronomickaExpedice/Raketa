
function sq(x) = x * x;

module ogive_nose_cone(radius, height, slices = 10, thickness = -1) {   //create ogive nose cone with rounded top tip
    
    rounding_level = height -  thickness/2;

    ogive_radius = (height * height + radius * radius) / (2 * radius);
    
    center_x = -ogive_radius + radius;
    center_y = 0;
    
    d = height / slices;
    rounding_sphere_radius = thickness/3;
    rounding_radius = w(rounding_level, ogive_radius); // radius of cone at rounding level

    rounding_sphere_height = rounding_sphere_radius - sqrt(sq(rounding_sphere_radius) - sq(rounding_radius));
    
    echo("rounding_sphere_height=", rounding_sphere_height);
    
    function w(y, r) = center_x + sqrt(
        (r * r) - (y * y)
    );
    
    
    difference () {
        rotate_extrude ($fn = slices)
        difference () {
            polygon(
                points = concat([
                    [0, height],
                    [0, 0],
                    [radius, 0]
                ],
                [ for (i = [0 : (slices - 1)]) [w(i * d, ogive_radius), i * d] ]),
                paths = [ [ for (i = [0 : (slices + 2)]) i ] ]
            );
            
            if (thickness > 0) {
                polygon(
                    points = concat([
                        [0, sqrt(sq(ogive_radius - thickness) - sq(ogive_radius - radius))],
                        [0, 0],
                        [radius - thickness, 0]
                    ],
                    [ for (i = [0 : (slices - 1)]) [w(i * d, ogive_radius - thickness), i * d] ]),
                    paths = [ [ for (i = [0 : (slices + 2)]) i ] ]
                );
            }
        }
        
        translate([0, 0 , rounding_level])      // top rounding to make the cone printable. 
        cylinder(r = radius, h = height);
    }
    translate([0, 0 , rounding_level])
    intersection() {
        cylinder(r=radius, h=height);
        translate([0, 0 , - rounding_sphere_radius + rounding_sphere_height ])
        sphere(rounding_sphere_radius, $fn=slices);
    }
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

module screw_anchor(outer_r, inner_r, depth, height, wall) {
	rotate([30, 0, 0])
	difference () {
		//translate([-outer_r / 2 - wall, outer_r / 2, 0])
		translate([-outer_r - wall, -wall, 0])
		cube([(outer_r + wall) * 2, depth, height]);

		//ccube(outer_r + wall * 2, outer_r + wall * 2, height);
		translate([0, outer_r, 0]) {
		cylinder(r = outer_r, h = height / 2);
		cylinder(r = inner_r, h = height);
		
		translate([-outer_r, 0, 0])
		cube([outer_r * 2, depth, height / 2]);
		}
	}
}


module tube(wall_thickness, diameter, lenght) {
    difference() {
        cylinder(d = diameter + wall_thickness * 2, h = lenght);
        translate([0, 0, -0.05]) cylinder(d = diameter, h = lenght + 0.1);
    }
}

module tube_twisted_in(wall_thickness, diameter, lenght, twist, count, teeth){
    difference() {
        tube(wall_thickness, diameter, lenght);
        translate([0, 0, -0.05]) twisted_ribs(diameter / 2, 0, lenght + 0.1, twist, count, teeth);
    }
}

module nozzle_die(wall_thickness, diameter, nozzle_lenght, dthroat, doutcome) {
    cylinder(d = diameter + wall_thickness + 2, h = wall_thickness);
    
    translate([0, 0, wall_thickness]) cylinder(d = diameter - 2, h = 2.5);
    
    translate([0, 0, wall_thickness + 2.5])cylinder(d1 = diameter - 2, d2 = doutcome, h = nozzle_lenght / 2);
    
    translate([0, 0, wall_thickness + nozzle_lenght / 2 + 2.5])cylinder(d1 = doutcome, d2 = dthroat, h = nozzle_lenght);
    translate([0, 0, nozzle_lenght + wall_thickness + 2.5 + nozzle_lenght / 2]) cylinder(d = dthroat, h = nozzle_lenght + 5);
}
