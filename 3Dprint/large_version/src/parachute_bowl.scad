include <global_parameters.scad>
use <library.scad>

$fn = 50;

parachute_bowl(RADIUS - WALL_TH * 2 - CLEARENCE, PARACHUTE_BOWL_DEPTH, RADIUS - WALL_TH, WALL_TH);