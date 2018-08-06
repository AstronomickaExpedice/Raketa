$fn = 30;

PrumerMotoru = 46;

module drzak() {
    difference() {
        translate([0, 0, 0]) cube([25, 8, 4]);
        translate([18, 4, 0]) cylinder(r=1.5, h=4);
        #translate([18, 4, 3]) cylinder(r1=1.5, r2=2, h=1);
    }
    cube([8, 8, 60]);
    CubePoints = [
      [  0,  -2,  0 ],
      [ 25,  -2,  0 ],
      [ 25,  0,  0 ],
      [  0,  0,  0 ],
      [  0,  -2,  60 ],
      [ 8,  -2,  60 ],
      [ 8,  0,  60 ],
      [  0,  0,  60 ]];      
    CubeFaces = [
      [0,1,2,3],
      [4,5,1,0],
      [7,6,5,4],
      [5,6,2,1],
      [6,7,3,2],
      [7,4,0,3]];
      
    polyhedron( CubePoints, CubeFaces );
}
module drzaky() {
    translate([PrumerMotoru/2, -3, 0]) drzak();
    rotate([0, 0, 120]) translate([PrumerMotoru/2, -3, 0]) drzak();
    rotate([0, 0, 120*2]) translate([PrumerMotoru/2, -3, 0]) drzak();
}
drzaky();

difference() {
    cylinder(r=PrumerMotoru/2+8, h=4);
    #cylinder(r=PrumerMotoru/2, h=4);
}