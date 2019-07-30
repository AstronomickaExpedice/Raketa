include <../config.scad>

module container() {
    difference() {
        union() {
            cylinder(d=outer_diameter, h=joint_height, $fn=100);

            translate([0, 0, joint_height])
                cylinder(d1=outer_diameter, d2=container_diameter, h=container_transition, $fn=100);

            translate([0, 0, joint_height+container_transition])
                cylinder(d=container_diameter, h=container_height, $fn=100);
        }

        cylinder(d=outer_diameter-wall_thickness*2, h=joint_height, $fn=100);

        translate([0, 0, joint_height])
            cylinder(d1=outer_diameter-wall_thickness*2, d2=container_diameter-wall_thickness*2, h=container_transition, $fn=100);

        translate([0, 0, joint_height+container_transition])
            cylinder(d=container_diameter-wall_thickness*2, h=container_height, $fn=100);

        translate([0, 0, joint_height+container_transition/2])
            rotate([0, 90, 0])
                #cylinder(d=hole_diameter, h=container_diameter, $fn=20);
    }
}

container();