include <global_parameters.scad>
use <library.scad>
// Printed bowel to parashute explosive filling.


$fn = 50;

CLEARENCE = 1; 
WALL_TH = 5;
RADIUS = 10;
PARACHUTE_BOWL_DEPTH = 4;

parachute_bowl(RADIUS - WALL_TH * 2 - CLEARENCE, PARACHUTE_BOWL_DEPTH, RADIUS - WALL_TH, WALL_TH);