$fn = 30;

prumerMotoru = 45;
prumerTyce = 8.5;
vyska = 30;
stena = 1.5;

module diraBok() {
    rotate([0, 90, 0]) hull() {
        translate([-vyska/2+8, 0, 0]) cylinder(r=2, h=prumerMotoru+stena*2, center=true);
        translate([vyska/2-8, 0, 0]) cylinder(r=2, h=prumerMotoru+stena*2, center=true);
    }
}

module diraDno() {
    hull() {
        translate([prumerTyce, 0, 0]) cylinder(r=2, h=stena);
        translate([prumerMotoru/2-stena-4, 0, 0]) cylinder(r=2, h=stena);
    }
}

module ring() {
    difference() {
        cylinder(r=prumerMotoru/2+stena, h=vyska);
        cylinder(r=prumerMotoru/2, h=vyska);
        #rotate([0, 0, 0]) translate([0, 0, vyska/2]) diraBok();
        #rotate([0, 0, 60]) translate([0, 0, vyska/2]) diraBok();
        #rotate([0, 0, 120]) translate([0, 0, vyska/2]) diraBok();
    }
}
module bottom() {
    difference() {
        cylinder(r=prumerMotoru/2+stena, h=stena);
        cylinder(r=prumerTyce/2, h=stena);
        #rotate([0, 0, 0]) diraDno();
        #rotate([0, 0, 60]) diraDno();
        #rotate([0, 0, 120]) diraDno();
        #rotate([0, 0, 120+60]) diraDno();
        #rotate([0, 0, 240]) diraDno();
        #rotate([0, 0, 240+60]) diraDno();
    }
}



bottom();
translate([0, 0, stena]) ring();