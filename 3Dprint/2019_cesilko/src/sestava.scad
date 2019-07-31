include <../config.scad>
use <hull.scad>
use <motor.scad>
use <container.scad>
use <nosecone.scad>

translate([0, 0, -module_height-joint_transition_height])
    motor();

translate([0, 0, 0])
color([1, 0, 0])
    hull();

translate([0, 0, module_height+joint_transition_height])
    container();

translate([0, 0, module_height+joint_transition_height*2+container_height+joint_height+joint_height*3/4])
    nosecone();