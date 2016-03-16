use <library.scad>
include <global_parameters.scad>

inner_radius = radius - 5;
height = 185;

// launch rocket holder
module launch_holder(rocket_radius, wire_diameter, height, wall, angle) {
    translate([wire_diameter/2 + wall , 0, 0])
    difference () {                 // hull shell of connection part.
        union (){
            cylinder(r = wire_diameter/2 + wall, h = height , $fn=resolution/2);
            translate([-(wire_diameter+3*wall) , -(wire_diameter+wall), 0])
            cube(size = [(wire_diameter + 3*wall),(wire_diameter + 6*wall),height]);
        }
        cylinder(r = wire_diameter/2, h = height, $fn=resolution/2);
        translate([-(rocket_radius + wire_diameter/2 + wall ),0, 0])
        cylinder(r = + rocket_radius, h = height , $fn=resolution);

        translate([ -1,(wire_diameter + 2*wall), 0])
        cylinder(r = wire_diameter/2 + wall, h = height , $fn=resolution/2);
        translate([ -1,-(wire_diameter + 2*wall), 0])
        cylinder(r = wire_diameter/2 + wall, h = height , $fn=resolution/2);
        translate([0 , 0, -height])
        rotate([0, -angle, 0])
        cube(2*height, center = true);

        translate([0 , 0, 2*height])
        rotate([0, angle, 0])
        cube(2*height, center = true);
    }
};

module payload_stage () {
    union () {    
        difference () {                 // hull shell
            cylinder(r = radius, h = connection_lenght , $fn=resolution);
            cylinder(r = radius - rib_wall, h = connection_lenght, $fn=resolution);
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

        // bevel/smooth transformation between connection and rest of the rocket hull 

        translate([0, 0, height - connection_lenght - 2*rib_wall])        
        difference () {                
            cylinder(               
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

        translate([radius, 0, connection_lenght/2 - 35/2])
        launch_holder(radius, 5, 35, wall, 30);
    }
}

payload_stage();
//launch_holder(radius, 5, 35, wall, 30);
