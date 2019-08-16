THICKNESS = 4;
RADIUS = 15;
LENGHT = 120;
TOLERANCE = 0.5;
$fn = 100;
stena_rakety = 4;

use <library.scad>
use <polyScrewThread.scad>



module nozzle2b_cap(radius, wall){
	translate([0, 0, 0]) hex_screw(29.7,4,55,15,1.5,2,24,0,0,0);
	translate([0, 0, -wall]) cylinder(d2 = (radius+wall)*2 ,d1 = (radius+wall)*2*3, h=wall);
    difference(){
        cylinder(20, RADIUS+THICKNESS*1+0.6+stena_rakety, RADIUS+THICKNESS*1+0.6+stena_rakety);
        cylinder(20, RADIUS+0.6+stena_rakety, RADIUS+0.6+stena_rakety);
    }
}


module nozzle2b_cap_hole(radius, wall){
    difference(){
        union(){
            translate([0, 0, 0]) hex_screw(29.7,4,55,15,1.5,2,24,0,0,0);
            translate([0, 0, -wall]) cylinder(d2 = (radius+wall)*2 ,d1 = (radius+wall)*2*3, h=wall);
            difference(){
                cylinder(20, RADIUS+THICKNESS*1+0.6+stena_rakety, RADIUS+THICKNESS*1+0.6+stena_rakety);
                cylinder(20, RADIUS+0.6+stena_rakety, RADIUS+0.6+stena_rakety);
            }
        }
        translate([0,0,11]){#cylinder(5, 3/2, 10/2);}
    }
}

//nozzle2b_cap(RADIUS, THICKNESS);
nozzle2b_cap_hole(RADIUS, THICKNESS);


