THICKNESS = 4;
RADIUS = 15;
LENGHT = 120;
NOZZLE_THROAT_RADIUS = 2;
NOZZLE_OUTCOME_RADIUS = 7;
NOZZLE_LENGHT = 7;
TOLERANCE = 0.5;
$fn = 100;

use <library.scad>
use <polyScrewThread.scad>



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

module nozzle_cap_thread(radius, wall){
	translate([0, 0, 0]) hex_screw(28,4,55,15,1.5,2,24,0,0,0);
	translate([0, 0, -wall]) cylinder(d = (radius+wall)*2, h=wall);
	
}


nozzle_holle(THICKNESS, RADIUS, 15/2, 20/2);
translate([0, 0, 0]) tube(THICKNESS, RADIUS, LENGHT);
difference(){
	translate([0, 0, LENGHT-20]) cylinder(d = RADIUS*2+THICKNESS, h=20);
	translate([0, 0, LENGHT-20]) hex_screw(30,4,55,30,1.5,2,24,0,0,0);
}

//nozzle_cap_thread(RADIUS, THICKNESS);


