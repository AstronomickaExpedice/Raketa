$fn = 60;

vyska = 90;

prumerM = 24.6;
delkaM = 70;
stena = 1.5;

delkaP = 15;
prumerP = 24;

delkaS = 35;
vyskaS = 80;
tloustkaS = 1.5;

module trup() {
    difference() {
        cylinder(r=prumerM/2+stena, h=vyska);
        cylinder(r=prumerM/2, h=delkaM);
        cylinder(r=prumerP/2-1.5, h=vyska);
        #rotate([0, 90, 0]) translate([-vyska+7, 0, -(prumerM/2)-5]) cylinder(r=1, h=10);
    }
    translate([0, 0, vyska]) difference() {
        cylinder(r=prumerP/2, h=delkaP);
        cylinder(r=prumerP/2-1.5, h=delkaP);
    }
}
module stabilizatory() {
    module stabilizator() {
        difference() {
            cube([delkaS, tloustkaS, vyskaS]);
            translate([0, 0, vyskaS]) rotate([0, 50, 0]) cube([delkaS+delkaS/2+2, tloustkaS, 30]);
        }
    }
    rotate([0, 0, 0]) translate([prumerM/2+stena, -(tloustkaS/2), 0]) stabilizator();
    rotate([0, 0, 120]) translate([prumerM/2+stena, -(tloustkaS/2), 0]) stabilizator();
    rotate([0, 0, -120]) translate([prumerM/2+stena, -(tloustkaS/2), 0]) stabilizator();
}
module voditko() {
    difference() {
        translate([2, 2, 0]) cylinder(r=3, h=10);
        translate([2, 2, 0]) cylinder(r=2, h=10);
        #rotate([0, 45, 0]) translate([-20, -2, 7]) cube([30, 8, 8]);
    }
}
trup();
stabilizatory();
translate([prumerM/2+stena, 1, 0]) voditko();