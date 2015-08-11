use <library.scad>
include <global_parameters.scad>


inner_radius = radius - 5;
height = stage_height;
motor_top = 173;
motor_bottom = 10;

rib_count = 18;

cone_height = 100;
cone_connection_height = 20;

$fn = 150;

include <rocket_nose.scad>



//////////
//
//      Rocket hull of the nose connection section
//
/////////

module lock_holl_out(radius, inner_radius, height, wall, motor_bottom, connection_lenght){
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3+wall);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3+wall);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3+wall);
}

module lock_holl_in(radius, inner_radius, height, wall, motor_bottom, connection_lenght){
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,connection_lenght/2])
		sphere(r=radius/3);
	/*
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		rotate([0,0,360/3])
		translate([0,0,height-(connection_lenght/2) ]);
		cylinder(r=radius-2*wall, h=radius);
		*/
		translate([0,0,(connection_lenght/2)-(radius/2)-clear ])
		cylinder(r=radius-wall-clear, h=(radius/2)*2+2*clear);
}

module recovery_stage () {
	difference(){
	union(){
		lock_holl_out(radius, inner_radius, height, wall, motor_bottom, connection_lenght);
		translate([0, 0, 0]) difference () {                 // bottom connection part  of the hull shell. 
			cylinder(r = radius, h = connection_lenght);
			cylinder(r = radius - wall, h = connection_lenght);
		}
	
		translate([0, 0, connection_lenght - clear ]) difference () {                 // hull shell
				cylinder(r = radius, h = height - connection_lenght - cone_connection_height);
				cylinder(r = radius - wall, h = height - connection_lenght - cone_connection_height);
			}
		
		translate([0, 0, height - cone_connection_height - 2*wall]) difference(){
			cylinder(r = radius, h = 4*wall);
		}

		
	
		// hull of the connection part. 
		translate([0, 0, height - cone_connection_height - 1*wall])
		difference () {                 // hull shell of connection part.
				cylinder(r = radius - wall, h = cone_connection_height+1*wall);
				cylinder(r = radius - 2*wall, h = cone_connection_height+1*wall);
		}
		
		translate([0, 0, height - cone_connection_height-2*wall])
		difference () {                 // hull shell of connection part.
				cylinder(r = radius, h = 1*wall);
				cylinder(r = radius - wall, h = 1*wall);
		}
		/*translate([0, 0, height - cone_connection_height-2*wall])
		difference () {                 // hull shell of connection part.
				cylinder(r = radius - 1*wall, h = 2*wall);
				cylinder(r = radius/2 - 2*wall - 2*clear, h = 2*wall);
		}*/
		
	
		// partition for parashute explosive charge.
		
	}
	union(){
			lock_holl_in(radius, inner_radius, height, wall, motor_bottom, connection_lenght);
			//translate([0,0,-clear]) cylinder(h=height+2*clear, r=radius-3*wall-clear);
			translate([0, 0, height-cone_connection_height-2*wall]) cylinder(h=4*wall, r=radius-2*wall);
			translate([0, 0, height-cone_connection_height-2*wall]) cylinder(h=4*wall, r1=radius-wall, r2 =  radius - 2*wall);
	}
	}
	
}


// object modifier
//translate([0, 0, height - cone_connection_height - wall])
//cylinder(r = radius + wall, h = height - cone_connection_height - wall, $fn=resolution);

recovery_stage ();

