$fn = 60;

vyska = 160;
prumer = 24.6;
stena = 1.5;

module voditko() {
    difference() {
        translate([2, 2, 0]) cylinder(r=3, h=10);
        translate([2, 2, 0]) cylinder(r=2, h=10);
        #rotate([0, 45, 0]) translate([-20, -2, 7]) cube([30, 8, 8]);
    }
}

difference() {
    cylinder(r=prumer/2+stena, h=vyska);
    cylinder(r=prumer/2, h=vyska);
}

translate([prumer/2+stena, 0, 0]) voditko();