$fn = 60;

prumer = 23.5;
vyska = 80;

difference() {
    cylinder(r=prumer/2, h=vyska);
    translate([-prumer/2, -0.8, 0]) cube([prumer, 4, 37]);     //GPS
    translate([-prumer/2, -17, 0]) cube([prumer, 15, 44]);    //arduino
    translate([-16/2, 4.2, 0]) cube([16, 15, 27.5]);            //accelerometr, magnetometr, gyroskop
    translate([-13/2, -3, 0]) cube([13, 3, 5]);
    translate([prumer/2-2.5, 1, 35]) cube([5, 2, vyska-35]);   //antena GPS
    #translate([10, 1, 30]) rotate([0, -55, 0]) cube([20, 2, 10]);  //antena GPS
    translate([-14/2, 4.2, 29]) cube([14, 10, 28]);             //vysilacka
    translate([-13.5/2, prumer/2-6, 26]) cube([13.5, 8, 6]);
    translate([0, 7, 26+31]) cylinder(r=2.6, h=20);            //antena vysilacka
    translate([-2.6, 7, 26+31]) cube([2.6*2, 10, 20]);         //antena vysilacka
    translate([0, -6, 47]) cylinder(r=11.5/2, h=29);           //baterka
    translate([-11.5/2, -15.5, 47]) cube([11.5, 10, 29]);      //baterka
    translate([-5.8, -prumer/2, 43]) cube([5.8*2, 3, 5]);
    #rotate([0, 0, -30]) translate([prumer/2-2.5, -1, 35]) cube([5, 2, vyska-35]); //bzucak
    #rotate([0, 0, -90-60]) translate([prumer/2-2.5, -1, 35]) cube([5, 2, vyska-35]); //bzucak
}

