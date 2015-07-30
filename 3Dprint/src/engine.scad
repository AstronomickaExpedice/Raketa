THICKNESS = 1.1;
RADIUS = 15 + 2.25;
LENGHT = 120;
NOZZLE_THROAT_RADIUS = 2;
NOZZLE_OUTCOME_RADIUS = 7;
NOZZLE_LENGHT = 7;
TOLERANCE = 0.5;
$fn = 100;

use <library.scad>


/*color([0, 0, 1]) translate([0, RADIUS + 50, 0]) nozzle_die(THICKNESS, RADIUS - TOLERANCE, NOZZLE_LENGHT, NOZZLE_THROAT_RADIUS, NOZZLE_OUTCOME_RADIUS);
*/


color([0, 1, 0]) union() {
    tube(THICKNESS, RADIUS, LENGHT);
}



//engine fuel 
/*color([1, 0, 0])translate([0, -RADIUS - 50, 0]) tube(RADIUS - NOZZLE_THROAT_RADIUS - 3*TOLERANCE, NOZZLE_THROAT_RADIUS + 2.25, LENGHT);
*/
// engine cup 

/*color([1, 1, 0]) translate([RADIUS + 50, 0, 0]) 
union() {
    cylinder(r = RADIUS + THICKNESS, h = 5);
    translate([0, 0, 5]) cylinder(r = RADIUS - TOLERANCE, h = 10);
}*/