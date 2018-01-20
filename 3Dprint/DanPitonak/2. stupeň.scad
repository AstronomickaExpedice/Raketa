a=100; b=10.7;
module stupen () {
    difference () {
    cylinder(a,b,b);
    translate ([0,0,-1]) cylinder (a+2,b-1.2,b-1.2);
}};

module uchyt () {
    difference () {
    translate ([11.9,3,0]) cylinder (10,2.8,2.8);
    translate ([11.9,3,-1]) cylinder (12,2,2);
}}

module prepazka () {
    translate ([-9.5,-2,20]) cube ([19,4,4]);
}

union () {
    stupen ();
    uchyt ();
    prepazka ();
}
