use <library.scad>
include <global_parameters.scad>


inner_radius = radius - 5;
height = 185;
motor_top = 173;
motor_bottom = 10;

rib_count = 18;

// circular grid fins
/*
fin_r = 50;
fin_h = 5;
fin_spacing = 10;
*/

// classic fins
fin_r = radius + 50;
fin_h = 60;
fin_angle = 16;

screw_outer_r = 2.5;
screw_inner_r = 1;
screw_length = 10;
/*
difference () {                 // hull shell
    cylinder(r = radius, h = connection_lenght , $fn=resolution);
    cylinder(r = radius - wall, h = connection_lenght, $fn=resolution);
}

translate([0, 0, connection_lenght - clear ]){   // remove ribs to place stage connection section
    difference () {                 // hull shell
        cylinder(r = radius, h = height - 2*connection_lenght , $fn=resolution);
        cylinder(r = radius - rib_wall, h = height - 2*connection_lenght, $fn=resolution);
    }

    difference () {
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
    }
}

translate([0, 0, height - connection_lenght])
difference () {                 // hull shell of connection part.
        cylinder(r = radius - rib_wall - clear, h = connection_lenght , $fn=resolution);
        cylinder(r = radius - 2*rib_wall - clear, h = connection_lenght, $fn=resolution);
}

translate([0, 0, height - connection_lenght - 2*rib_wall])        
difference () {                
    cylinder(               // bevel/smooth transformation between connection and rest of the rocket hull 
            r = radius,
            h = 2*rib_wall,
            $fn=resolution
    );

    cylinder(               // bevel/smooth transformation between connection and rest of the rocket hull 
            r1 = radius - rib_wall,
            r2 = radius - 2*rib_wall ,
            h = 2*rib_wall,
            $fn=resolution
    );
}
*/

// object modifier
translate([0, 0, connection_lenght])
cylinder(r = radius, h = height - connection_lenght , $fn=resolution);
