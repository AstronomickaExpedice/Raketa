include <../config.scad>
use <hull.scad>
use <motor.scad>

translate([0, 0, -module_height-1])
    motor();

translate([0, 0, 0])
color([1, 0, 0])
    hull();