$fn = 60;

prumerM = 24.6;
stena = 1.5;
vyska = 100;

stena = 1.5;
prumerP = 24;
delkaP = 15;

translate([0, 0, delkaP]) difference() {
    cylinder(r=prumerM/2+stena, h=vyska);
    translate([0, 0, vyska-2]) cylinder(r1=prumerP/2, r2=prumerM/2+stena, h=2);
    cylinder(r=prumerM/2, h=vyska);
    #rotate([0, 90, 0]) translate([-vyska+20, 2, 5]) cylinder(r=1.5, h=10);
    #rotate([0, 90, 0]) translate([-vyska+20, -2, 5]) cylinder(r=1.5, h=10);
}
difference() {
    cylinder(r=prumerP/2, h=delkaP+5);
    cylinder(r=prumerP/2-stena, h=delkaP+5);
}
translate([0, 0, 2.5]) cube([prumerP-1, 2, 5], center=true);
translate([0, 0, delkaP-2]) cylinder(r1=prumerP/2, r2=prumerM/2+stena, h=2);