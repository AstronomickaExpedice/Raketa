include <../config.scad>
use <lib/cone_lib.scad>

module nosecone() {
    tangent_ogive_cone(R=container_diameter/2, L=cone_height, rn=1, thk=wall_thickness);
    difference() {
        union() {
            translate([0, 0, -joint_transition_height])
                cylinder(d2=container_diameter, d1=container_diameter-wall_thickness*2-joint_space*2, h=joint_transition_height, $fn=100);

            translate([0, 0, -joint_transition_height-joint_height*3/4])
                cylinder(d=container_diameter-wall_thickness*2-joint_space*2, h=joint_height*3/4, $fn=100);
        }

        translate([0, 0, -joint_transition_height-joint_height*3/4])
            cylinder(d=container_diameter-wall_thickness*2-joint_space*2-joint_thickness, h=joint_transition_height+joint_height*3/4, $fn=100);
    }

    translate([0, 0, -joint_transition_height-joint_height*3/4])
        intersection() {
            cylinder(d=container_diameter-wall_thickness*2-joint_space*2, h=10, $fn=100);
            translate([0, 0, 1.5])
                cube([container_diameter, 1, 3], center=true);
        }
}

nosecone();