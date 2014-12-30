
use <library.scad>

radius = 30;
inner_radius = 20;

wall = 0.6;
height = 100;
motor_top = 80;
motor_bottom = 20;

rib_count = 12;

fin_r = 50;
fin_h = 5;
fin_spacing = 5;

screw_outer_r = 2.5;
screw_inner_r = 1;
screw_length = 10;


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


module motor_holder() {
	intersection () {
		for (i = [0 : 1]) {
			rotate([0, 0, i * 180])
			translate([inner_radius * 0.2, -radius, 0])
			cube([radius - inner_radius * 0.2, radius * 2, wall * 4]);

			//rotate([0, 0, 90 + i * 180])
			//translate([inner_radius / 2, -radius, wall * 4])
			//cube([wall * 4, radius * 2, wall * 4]);
		}
	
		cylinder(r = radius, h = height); 
	}
}


module circular_grid_fin(outer_r, inner_r, wall, spacing, height) {
	ring(outer_r, wall, height);
	
	c = (outer_r * 2) / spacing;
	
	difference () {
	intersection () {
		union () {
			for (i = [1 : (c - 1)]) {
				translate([-outer_r + i * spacing - wall / 2, -outer_r, 0])
				cube([wall, outer_r * 2, height]);

				translate([-outer_r, -outer_r + i * spacing - wall / 2, 0])
				cube([outer_r * 2, wall, height]);
			}
		}
		
		cylinder(r = outer_r, h = height);
	}
	cylinder(r = inner_r, h = height);
	}
}


module hull(radius, inner_radius, height, wall, motor_bottom) {
	difference () {
		cylinder(r = radius, h = height);
		cylinder(r = radius - wall, h = height);
	}


	difference () {
		union () {
			twisted_ribs(
				radius,
				inner_radius,
				height,
				60,
				rib_count,
				wall
			);
			/*
			twisted_ribs(
				radius,
				inner_radius,
				height,
				-10,
				rib_count,
				wall
			);
			*/
		}
		
		cylinder(
			r1 = radius - wall,
			r2 = inner_radius,
			h = motor_bottom
		);
	}
}


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


/*
translate([0, 0, height - 20])
intersection () {
	for (i = [0 : 1]) {
		rotate([0, 0, i * 180])
		translate([0, radius, 0])
		screw_anchor(screw_outer_r, screw_inner_r, radius, screw_length * 2, wall * 3);
	}
	translate([0, 0, -height / 2])
	cylinder(r = radius, h = height);
}
*/

circular_grid_fin(fin_r, radius - wall, wall, fin_spacing, fin_h);


difference () {
	union () {
		hull(radius, inner_radius, height, wall, motor_bottom);

		translate([0, 0, motor_top])
		motor_holder();
	}
	
	/*
	translate([0, 0, height - 20])
	for (i = [0 : 1]) {
		rotate([0, 0, i * 180])
		translate([0, radius, 0])
		translate([0, outer_r, 0])
		cylinder(r = screw_outer_r, h = screw_length);
	}
	*/
}

