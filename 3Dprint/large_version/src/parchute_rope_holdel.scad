include <global_parameters.scad>

$fn = 150;

difference() {
    cylinder(r = PARACHUTE_ROPE_HOLDER_R, h = PARACHUTE_ROPE_HOLDER_H);
    translate([0, 0, -0.05]) for(i = [0 : 360 / PARACHUTE_ROPE_HOLDER_CYLINDERS : 360]) {
        rotate([0, 0, i]) translate([PARACHUTE_ROPE_HOLDER_CYLINDERS_OFFSET, 0, 0]) cylinder(r = PARACHUTE_ROPE_HOLDER_CYLINDERS_R, h = PARACHUTE_ROPE_HOLDER_H + 0.1);
    }
}