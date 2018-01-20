use <library.scad>
include <global_parameters.scad>
//Middle payload stage.

inner_radius = radius - 5;
height = 185;

$fn = 150;

module lock_out(radius, inner_radius, height, wall, connection_lenght){
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3);
}

module lock_in(radius, inner_radius, height, wall, connection_lenght){
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		translate([0,0,height-(connection_lenght/2)-(radius/3) ])
		cylinder(r=radius-2*wall-clear, h=(radius/3)*2);
}

module lock_holl_out(radius, inner_radius, height, wall,  connection_lenght){
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3+wall);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3+wall);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3+wall);
}

module lock_holl_in(radius, inner_radius, height, wall,  connection_lenght){
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3);

		translate([0,0,(connection_lenght/2)-(radius/2)-clear ])
		cylinder(r=radius-wall, h=(radius/2)*2+2*clear);
}


module payload_stage () {
	difference(){
		union(){
			difference () {                 // hull shell
				cylinder(r = radius, h = connection_lenght);
				translate([0,0,-clear]) cylinder(r = radius - wall, h = connection_lenght + 2*clear);
			}
		
			translate([0, 0, connection_lenght - clear ]){   // remove ribs to place stage connection section
				difference () {                 // hull shell
					cylinder(r = radius, h = height - 2*connection_lenght);
					translate([0,0,-clear]) cylinder(r = radius - wall, h = height - 2*connection_lenght + 2*clear);
				}
		
				/*difference () {
						union () {
								twisted_ribs(
										radius - (wall / 2),
										inner_radius,
										height-connection_lenght,
										90,
										rib_count,
										rib_wall
								);						
						}
						
						cylinder(r1 = radius - wall, r2 = inner_radius, h = 15 ); // bevel inner ribs for better printing.
						
				// connection to the next rocket stage
						translate([0, 0, height - 2*connection_lenght])   // remove ribs to place stage connection section
						difference () {                
								cylinder(r = radius, h = connection_lenght , $fn=resolution);
								cylinder(r = radius- 1.5*rib_wall, h = connection_lenght, $fn=resolution);
						}
				}*/
			}
		
			translate([0, 0, height - connection_lenght])
			difference () {                 // hull shell of connection part.
					cylinder(r = radius - wall - clear, h = connection_lenght);
					translate([0,0,-clear]) cylinder(r = radius - 2*wall - clear, h = connection_lenght+2*clear);
			}
		
			// bevel/smooth transformation between connection and rest of the rocket hull 
		
			translate([0, 0, height - connection_lenght - 3*wall])        
			difference () {                
                // bevel/smooth transformation between connection and rest of the rocket hull 
                cylinder(r = radius, h = 3*wall);
				translate([0,0,-clear]) cylinder(r1 = radius - wall, r2 = radius - 2*wall  - clear, h = 3*wall + 2*clear);
			}
			lock_out(radius, inner_radius, height, wall, connection_lenght);
			lock_holl_out(radius, inner_radius, height, wall, connection_lenght);
		}
		union(){
			lock_in(radius, inner_radius, height, wall, connection_lenght);
			lock_holl_in(radius, inner_radius, height, wall,  connection_lenght);
		}
	}

    //translate([radius, 0, connection_lenght/2 - 35/2])
    //launch_holder(radius, 5, 35, wall, 30);
}

payload_stage();
