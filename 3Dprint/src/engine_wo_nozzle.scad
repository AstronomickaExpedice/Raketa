THICKNESS = 1.1;
RADIUS = 15;
LENGHT = 120;
NOZZLE_THROAT_RADIUS = 2;
NOZZLE_OUTCOME_RADIUS = 7;
NOZZLE_LENGHT = 7;
TOLERANCE = 0.5;
$fn = 100;

use <library.scad>

module nozzle_holle(wall, radius, nozzle_in, nozzle_out){
	difference(){
		union(){
			cylinder(r = radius, h = wall);
			translate([0,0,0]) cylinder(r = radius, h = 15);
			translate([0,0,0]) cylinder(r = radius);
		}
		union(){
			translate([0,0,0-clear]) cylinder(r = nozzle_in, h = 20);
			translate([0,0,10]) cylinder(r = nozzle_out, h = 8);
		}
	}
}
nozzle_holle(THICKNESS, RADIUS, 15/2, 20/2);
translate([0, 0, 0]) tube(THICKNESS, RADIUS, LENGHT);
