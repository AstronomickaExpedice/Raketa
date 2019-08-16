$fn = 60;

stena = 1.5;
prumerP = 24;
delkaP = 15;

prumerM = 24.6;

pocetClanku = 15;

skoky=[
    prumerM/2+stena,
    prumerM/2+stena-0.2,
    prumerM/2+stena-0.44,
    prumerM/2+stena-0.7,
    prumerM/2+stena-1,
    prumerM/2+stena-1.4,
    prumerM/2+stena-1.8,
    prumerM/2+stena-2.2,
    prumerM/2+stena-2.7,
    prumerM/2+stena-3.4,
    prumerM/2+stena-4.2,
    prumerM/2+stena-5.2,
    prumerM/2+stena-6.5,
    prumerM/2+stena-8.2,
    prumerM/2+stena-10.6,
    0,
];

module spicka() {
    for (i=[0 : 1 :pocetClanku-1]) {
        a=i;
        b=i+1;
        translate([0, 0, i*5]) cylinder(r1=skoky[a], r2=skoky[b], h=5);
    }
}
translate([0, 0, delkaP]) difference() {
    spicka();
    scale(0.8) spicka();
}

difference() {
    union() {
        cylinder(r=prumerP/2, h=delkaP+5);
        translate([0, 0, delkaP-2]) cylinder(r1=prumerP/2, r2=prumerM/2+stena, h=2);
    }
    cylinder(r=prumerP/2-stena, h=delkaP+5);
}