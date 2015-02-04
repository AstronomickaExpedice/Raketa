use <library.scad>
include <global_parameters.scad>

inner_radius = radius - 5;
height = 185;
motor_top = 173;
motor_bottom = 10;

rib_count = 18;

cone_height = 100;
cone_connection_height = 20;


//////////
//
//      Rocket nose cone
//
/////////

//translate([0, 0, 100 ])   // separate nose from the hull


//translate([0, 0, height - cone_connection_height ])   // move cone to the top of the rocket.
union () {
    translate([0, 0, cone_connection_height ])   // move cone to the top of the rocket.
    ogive_nose_cone(radius, cone_height, resolution, wall);

    difference () {                 // bottom connection part  of the hull shell. 
        cylinder(r = radius, h = cone_connection_height , $fn=resolution);
        cylinder(r = radius - wall, h = cone_connection_height, $fn=resolution);
    }    
}



//////////
//
//      Rocket hull of the nose connection section
//
/////////

/*
difference () {                 // bottom connection part  of the hull shell. 
    cylinder(r = radius, h = connection_lenght , $fn=resolution);
    cylinder(r = radius - rib_wall, h = connection_lenght, $fn=resolution);
}

translate([0, 0, connection_lenght - clear ]){   // remove ribs to place stage connection section
    difference () {                 // hull shell
        cylinder(r = radius, h = height - connection_lenght - cone_connection_height, $fn=resolution);
        cylinder(r = radius - rib_wall, h = height - connection_lenght - cone_connection_height, $fn=resolution);
    }

    difference () {
            union () {
                    twisted_ribs( radius - (wall / 2), inner_radius, height-connection_lenght - cone_connection_height,
                    90, rib_count, rib_wall);
            }
            
            cylinder(r1 = radius - wall, r2 = inner_radius, h = 15 ); // bevel inner ribs for better printing.
            
    // connection to the cone remove ribs
            translate([0, 0, height - connection_lenght - cone_connection_height])   // remove ribs to place stage connection section
            difference () {                
                    cylinder(r = radius, h = cone_connection_height , $fn=resolution);
                    cylinder(r = radius-1.5*wall, h = cone_connection_height, $fn=resolution);
            }
    }
}

// hull of the connection part. 
translate([0, 0, height - cone_connection_height])
difference () {                 // hull shell of connection part.
        cylinder(r = radius - wall - 2*clear, h = cone_connection_height , $fn=resolution);
        cylinder(r = radius - 2*wall - 2*clear, h = cone_connection_height, $fn=resolution);
}

// partition for parashute explosive charge.
translate([0, 0, height - cone_connection_height - wall])        
cylinder(r = radius, h = 2*wall, $fn=resolution );




// object modifier
//translate([0, 0, height - cone_connection_height - wall])
//cylinder(r = radius + wall, h = height - cone_connection_height - wall, $fn=resolution);
*/