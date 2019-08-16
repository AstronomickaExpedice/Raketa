THICKNESS = 4;
RADIUS = 15;
LENGHT = 120;
NOZZLE_THROAT_RADIUS = 2;
NOZZLE_OUTCOME_RADIUS = 7;
NOZZLE_LENGHT = 7;
TOLERANCE = 0.5;
$fn = 150;

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
	difference(){
		union(){
			translate([0, 0, 0]) hex_screw(29.6,4,55,15,1.5,2,24,0,0,0);
			translate([0, 0, -wall]) cylinder(d2 = (radius+wall)*2 ,d1 = (radius+wall)*2*3, h=wall);
			
			translate([0, 0, -wall]) difference(){
					cylinder(h=14+wall, r1=37/2+wall*2, r2=37/2+wall*1);
					cylinder(h=15+wall, r=37/2+1);
			}
			difference(){
					cylinder(h=21, r=13);
					cylinder(h=22, r=12);
			}
		}
		union(){
			translate([0, 0, 10]) cylinder(h=5.1, r1=6/2, r2=12.18);
			
			
		}
	}
}


nozzle_holle(THICKNESS, RADIUS, 15/2, 20/2);
translate([0, 0, 15]) difference() {
    tube(RADIUS - 10, 10, 10);
    cylinder(r1 = 10, r2 = RADIUS, h = 10);
}
translate([0, 0, 0]) tube(THICKNESS, RADIUS, LENGHT);
difference(){
	translate([0, 0, LENGHT-20]) cylinder(d = RADIUS*2+THICKNESS, h=20);
	translate([0, 0, LENGHT-20]) hex_screw(30,4,55,30,1.5,2,24,0,0,0);
}

//nozzle_cap_thread(RADIUS, THICKNESS);


