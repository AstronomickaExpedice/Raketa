THICKNESS = 1.1;
RADIUS = 15;
LENGHT = 120;
NOZZLE_THROAT_RADIUS = 2;
NOZZLE_OUTCOME_RADIUS = 7;
NOZZLE_LENGHT = 7;
TOLERANCE = 0.5;
$fn = 50;
include <global_parameters.scad>
use <library.scad>

module patrona(radius, lenght, in_radius, wall, clear){
	difference(){
		union(){
			translate([0,0,0]) cylinder(r=radius, h=lenght);
		}
		union(){
			translate([0,0,0]) cylinder(r=radius-wall, h=lenght+clear);
		}
	}
	difference(){
		union(){
			translate([0,0,0]) cylinder(r=in_radius+wall, h=lenght);
		}
		union(){
			translate([0,0,0]) cylinder(r=in_radius, h=lenght+clear);
			a = 0;
			for ( i = [0 : lenght/5] ){
				rotate([0,0,i*30]);
				translate([0,0,i*5]) rotate([90,0,i*90]) cylinder(h=(in_radius+wall)*2, r=in_radius/3*2.25, center=true);
			}
		}
	}
	translate([0,0, -4*wall]) cylinder(r=radius, h=4*wall);
}


patrona(28.75/2, 100, 10/2, 0.6, clear);
