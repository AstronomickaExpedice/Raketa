include <../../config.scad>

module joint() {
    difference() {
        union() {
            cylinder(d=outer_diameter, h=1, $fn=100);

            translate([0, 0, 1])
                cylinder(d=outer_diameter-wall_thickness*2-joint_space*2, h=joint_height, $fn=100);
        }

        cylinder(d1=outer_diameter-wall_thickness*2, d2=outer_diameter-wall_thickness-joint_space-joint_thickness, h=1, $fn=100);

        cylinder(d=outer_diameter-wall_thickness-joint_space-joint_thickness, h=joint_height+1.1, $fn=100);
    }
}

joint();