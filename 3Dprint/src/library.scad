
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
			square([wall, wall]);
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

module tube(wall_thickness, radius, lenght) {
    difference() {
        cylinder(r = radius + wall_thickness, h = lenght);
        translate([0, 0, -0.05]) cylinder(r = radius, h = lenght + 0.1);
    }
}

module tube_twists_in(wall_thickness, radius, lenght, teeth_twist, teeth_count, teeth_size) {
    difference () {
        twisted_ribs(radius, radius - teeth_size, lenght, teeth_twist, teeth_count, teeth_size);						
        cylinder(r1 = radius - lenght, r2 = radius - wall_thickness, h = lenght);
    }
    tube(wall_thickness, radius, lenght);
    
}

module nozzle_die(wall_thickness, radius, nozzle_lenght, r_throat, r_outcome) {
difference () {
    union () {
        cylinder(r = radius + wall_thickness + 2, h = wall_thickness);    
        translate([0, 0, wall_thickness]) cylinder(r = radius, h = 2.5);
        translate([0, 0, wall_thickness + 2.5])cylinder(r1 = radius, r2 = r_outcome, h = nozzle_lenght / 2);
        translate([0, 0, wall_thickness + nozzle_lenght / 2 + 2.5])cylinder(r1 = r_outcome, r2 = r_throat, h = nozzle_lenght);
    }
    cylinder(r = r_throat, h = 3*nozzle_lenght);
}
}

module concentric_cylinders(r, l, thickness, cylinders, spacing) {
    for(i = [0 : cylinders - 1]) {
        tube(thickness, i * (spacing + thickness) + r, l);
    }
}

module pcb_holder (pcb_height, pcb_width, pcb_depth, pcb_holder_overlap, wall_thickness, bottom_thickness, radius)
{
	translate([-radius,-wall_thickness - pcb_depth/2,0])
	{
		difference()
		{
			cube([radius*2, wall_thickness * 2 + pcb_depth, pcb_height + bottom_thickness]);
			union()
			{
				translate([radius - pcb_width/2,wall_thickness,bottom_thickness]) cube([pcb_width, pcb_depth, pcb_height + 0.05]);
				translate([radius - pcb_width/2 + pcb_holder_overlap,-0.05,-0.05]) cube([pcb_width - 2*pcb_holder_overlap,wall_thickness * 2 + pcb_depth+0.1,pcb_height + bottom_thickness+0.1]);
				translate([radius,wall_thickness + pcb_depth/2,-0.05]) tube(radius - pcb_width/2, radius, pcb_height + bottom_thickness+0.1);
			}
		}
	}
}

module triangle_3d(lenght, width, height)
{
	polyhedron(
	points=[[0,0,0],[lenght,0,0],[lenght,width,0],[0,width,0],[0,0,height],[lenght,0,height]],
	faces=[[0,1,2,3],[0,4,5,1],[5,4,3,2],[5,2,1],[3,4,0]]);
}
module pcb_holder_supports(pcb_height, pcb_width, pcb_depth, pcb_holder_overlap, wall_thickness, bottom_thickness, radius, support_height)
{
	translate([0,0,support_height]) pcb_holder(pcb_height, pcb_width, pcb_depth, pcb_holder_overlap, wall_thickness, bottom_thickness, radius);
	difference()
	{
		union()
		{
			translate([radius,wall_thickness + pcb_depth/2,support_height]) rotate([180,0,270]) triangle_3d(wall_thickness * 2 + pcb_depth, radius - pcb_width/2 + pcb_holder_overlap, support_height);
			mirror([1,0,0]) translate([radius,wall_thickness + pcb_depth/2,support_height]) rotate([180,0,270]) triangle_3d(wall_thickness * 2 + pcb_depth, radius - pcb_width/2 + pcb_holder_overlap, support_height);
		}
		tube(radius - pcb_width/2, radius, pcb_height + bottom_thickness+0.1);
	}
}

