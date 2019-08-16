include <../config.scad>
use <lib/joint.scad>

module hull() {
    difference() {
        cylinder(d=outer_diameter, h=module_height, $fn=100);
        translate([0, 0, -0.1])
            cylinder(d=outer_diameter-wall_thickness*2, h=module_height+0.1, $fn=100);
    }
    translate([0, 0, module_height])
        joint();

}

hull();