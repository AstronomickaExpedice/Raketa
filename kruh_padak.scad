$fn = 60;

prumer = 15;
prumerDiry = 2.2;
pocetLan = 6;
vyska = 3;
uhel = 360/pocetLan;

difference() {
    cylinder(r=prumer/2, h=vyska);
    for (i = [0 : pocetLan]) {
        #rotate([0, 0, i*uhel]) translate([prumer/2-2, 0, 0]) cylinder(r=prumerDiry/2, h=vyska);
    }
}