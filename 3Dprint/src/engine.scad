THICKNESS = 3;
RADIUS = 15;
LENGHT = 120;
NOZZLE_THROAT_RADIUS = 2;
NOZZLE_OUTCOME_RADIUS = 5;
NOZZLE_LENGHT = 7;
TOLERANCE = 0.25;
$fn = 50;

use <library.scad>


//color([0, 0, 1]) translate([0, RADIUS + 50, 0]) nozzle_die(THICKNESS, RADIUS - TOLERANCE, NOZZLE_LENGHT, NOZZLE_THROAT_RADIUS, NOZZLE_OUTCOME_RADIUS);

color([0, 1, 0]) union() {
    difference() {
            tube_twists_in(THICKNESS, RADIUS, THICKNESS + NOZZLE_LENGHT, 45, 8, 5);
            translate([0, 0, -THICKNESS]) nozzle_die(THICKNESS, RADIUS, NOZZLE_LENGHT, NOZZLE_THROAT_RADIUS, NOZZLE_OUTCOME_RADIUS);
    }
    translate([0, 0, THICKNESS + NOZZLE_LENGHT-TOLERANCE]) tube(THICKNESS, RADIUS, LENGHT - THICKNESS - NOZZLE_LENGHT);
}



//engine fuel 
//color([1, 0, 0])translate([0, -RADIUS - 50, 0]) tube(RADIUS - NOZZLE_THROAT_RADIUS - 1, NOZZLE_THROAT_RADIUS + 2.25, LENGHT - NOZZLE_LENGHT - 2.5);

// engine cup 

/*color([1, 1, 0]) translate([RADIUS + 50, 0, 0]) 
union() {
    cylinder(r = RADIUS + THICKNESS, h = 10);
    translate([0, 0, 10]) cylinder(r = RADIUS - TOLERANCE, h = 10);
}*/