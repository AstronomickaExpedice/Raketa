difference() {
    union() {
        cylinder(r=10, h=3);
        #translate([0, 0, 16/2+3]) cube([18, 8, 18], center=true);
        translate([1.5, 0, 15/2+3+16]) cube([6, 7, 14], center=true);
        translate([1.5/-2, 0, 10+16+3+14]) cube([1.5, 7, 20], center=true);
    }
    translate([0, 5, 11]) rotate([90, 0, 0]) cylinder(r=7, h=10);
}