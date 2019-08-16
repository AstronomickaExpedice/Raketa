include <../config.scad>

module parachute_ring() {
    difference() {
        cylinder(d=parachute_ring_diameter, h=parachute_ring_thickness, $fn=100);

        for(i = [1:parachute_ring_hole_count]) {
            rotate([0, 0, i*(360/parachute_ring_hole_count)])
                translate([parachute_ring_diameter/2-parachute_ring_hole_diameter/2-parachute_ring_hole_distance, 0, parachute_ring_thickness/-2])
                cylinder(d=parachute_ring_hole_diameter, h=parachute_ring_thickness*2, $fn=20);
        }
    }
}

parachute_ring();