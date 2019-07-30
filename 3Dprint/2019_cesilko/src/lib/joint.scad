include <../../config.scad>

module joint() {
    difference() {
        union() {
            cylinder(d=outer_diameter, h=joint_transition_height, $fn=100);

            translate([0, 0, joint_transition_height])
                cylinder(d=outer_diameter-wall_thickness*2-joint_space*2, h=joint_height, $fn=100);
        }

        cylinder(d1=outer_diameter-wall_thickness*2, d2=outer_diameter-wall_thickness*2-joint_space*2-joint_thickness*2, h=joint_transition_height, $fn=100);

        cylinder(d=outer_diameter-wall_thickness*2-joint_space*2-joint_thickness*2, h=joint_height+0.1+joint_transition_height, $fn=100);
    }
}

joint();