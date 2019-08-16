include <global_parameters.scad>
use <library.scad>

module ogive_nose () {
    translate([0, 0, cone_connection_height ])   // move cone to the top of the rocket.
    ogive_nose_cone(radius, cone_height, resolution, wall);

    difference () {                 // bottom connection part  of the hull shell. 
        cylinder(r = radius, h = cone_connection_height , $fn=resolution);
        translate([0,0,-clear]) cylinder(r = radius - wall, h = cone_connection_height+2*clear, $fn=resolution);
    }    
}

ogive_nose();