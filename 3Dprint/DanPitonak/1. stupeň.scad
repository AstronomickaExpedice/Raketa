a=100; b=10.7;
module stupen () {
    difference () {
    cylinder(a,b,b);
    translate ([0,0,-1]) cylinder (a+2,b-1.2,b-1.2);
}}

module spojkavolna () {
    difference () {
    translate ([0,0,98]) cylinder (a/8,9.5,9.5);
    translate ([0,0,97]) cylinder (a/8+2,8.3,8.3);
    }}

module zarazka () {
    difference () {
    translate ([0,0,70]) cylinder (5,9.5,9.5);
    translate ([0,0,69]) cylinder (7,6,6);
    }}
translate ([0,0,69.7]) cylinder (0.3,9.5,9.5);

module prepazka () {
    translate ([-9.5,-2,90]) cube ([19,4,4]);
}

module hand (scale=10) {
    rotate ([90,0,0]) linear_extrude(height = scale*0.08, center = true)
    polygon (points=[[0,0],[0,50],[30,20],[30,0]]);
}

module uchyt () {
    difference () {
    translate ([11.9,3,0]) cylinder (10,2.8,2.8);
    translate ([11.9,3,-1]) cylinder (12,2,2);
}}

union () {
    stupen();
    spojkavolna();
    zarazka ();
    prepazka ();
    translate ([10.2,0,0]) hand();
    translate ([-10.2,0,0]) rotate (180) hand();
    translate ([0,10.2,0]) rotate (90) hand();
    translate ([0,-10.2,0]) rotate (270) hand();
    uchyt ();
} ;