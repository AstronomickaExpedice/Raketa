include <../config.scad>
use <lib/joint.scad>

module stabilizer() {
    difference() {
        translate([outer_diameter/2, stabilizer_thickness/-2, 0])
            cube([stabilizer_width, stabilizer_thickness, stabilizer_height]);

        translate([outer_diameter/2, stabilizer_thickness/-1, stabilizer_height])
            rotate([0, stabilizer_angle, 0])
                cube([100, stabilizer_thickness*2, 100]);
    }
}

module motor() {
    difference() {
        cylinder(d=outer_diameter, h=module_height, $fn=100);

        cylinder(d=motor_diameter, h=motor_height, $fn=100);

        translate([0, 0, motor_height])
            cylinder(d=outer_diameter-wall_thickness*2, h=module_height-motor_height, $fn=100);
    }

    translate([0, 0, module_height])
        joint();

    for(i = [1:stabilizer_count]) {
        rotate([0, 0, i*(360/stabilizer_count)])
            stabilizer();
    }

    if(liftoff_ring) {
        rotate([0, 0, 9]) {
            translate([outer_diameter/2+ring_diameter/2, 0, 0])
                difference() {
                    cylinder(d=ring_diameter+ring_thickness*2, h=ring_height, $fn=40);
                    cylinder(d=ring_diameter, h=ring_height+0.1, $fn=40);
                    translate([(ring_diameter+ring_thickness*2)/-2, (ring_diameter+ring_thickness*2)/-2, ring_height])
                        rotate([0, 30, 0])
                            cube([ring_diameter+ring_thickness*5, ring_diameter+ring_thickness*2, 10]);
                }

            translate([outer_diameter/2+ring_diameter/2, 0, module_height-ring_height])
                difference() {
                    cylinder(d=ring_diameter+ring_thickness*2, h=ring_height, $fn=40);
                    cylinder(d=ring_diameter, h=ring_height+0.1, $fn=40);
                    translate([(ring_diameter+ring_thickness*2)/-2, (ring_diameter+ring_thickness*2)/-2, -10])
                        rotate([0, -30, 0])
                            cube([ring_diameter+ring_thickness*50, ring_diameter+ring_thickness*2, 10]);
                    translate([(ring_diameter+ring_thickness*2)/-2, (ring_diameter+ring_thickness*2)/-2, ring_height])
                        rotate([0, 30, 0])
                            cube([ring_diameter+ring_thickness*5, ring_diameter+ring_thickness*2, 10]);
                }
        }
    }
}

motor();