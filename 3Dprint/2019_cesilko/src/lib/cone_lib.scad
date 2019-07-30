module tangent_ogive_cone(R=10, L=50, rn=0, thk=0) {
    /*
     * R   = radius of base
     * L   = length to point
     * rn  = spherical radius of tip. (default = 0)
     * thk = skin thickness. 0 = solid
     */
    if(thk <= 0){
        toc(R=R, L=L, rn=rn, thk=R);
    } else {
        toc(R=R, L=L, rn=rn, thk=thk);
    }
}

module toc(R=10, L=50, rn=0, thk=2) {

    Rho = (pow(R, 2) + pow(L, 2)) / (2 * R);    
    xo = L - sqrt(pow(Rho - rn, 2)-pow(Rho - R, 2));
    yt = (rn*(Rho-R))/(Rho-rn);
    xt = xo - sqrt(pow(rn,2)-pow(yt,2));

    rotate_extrude(convexity=10, $fn=128){
        union(){
            translate([0,L-xo,0])
                intersection(){
                    difference(){
                        circle(r=rn, $fn=256);
                        circle(r=rn-thk, $fn=256);
                    }
                    square(rn);
                }
            intersection(){
                difference(){
                    translate([-Rho+R,0,0])
                        circle(r=Rho, $fn=256);
                    translate([-Rho+R,0,0])
                        circle(r=Rho-thk, $fn=256);
                }
                square([R,L-xt]);
            }
        }
    }
}
module haack_cone(R=10, L=50, C=0, thk=0) {
    /*
     * R   = radius of base
     * L   = length to point
     * C   = Adjust cone shape between 0 and 1
     * thk = skin thickness. 0 = solid
     */
    pi = 3.14159265359;
    
//    function sig(x) = acos(1-((2*x)/L));
//    function y(x) = (R/sqrt(pi))*sqrt((sig(x)/(180/pi))-(sin(2*sig(x))/2)+(C * pow(sin(sig(x)),3)));
    
//    pts = concat([ for (a = [0 : L/512 : L]) [ a, y(a) ] ], [[L, 0]]);

    function sig(x, l) = acos(1-((2*x)/l));
    function y(x, r, l) = (r/sqrt(pi))*sqrt((sig(x, l)/(180/pi))-(sin(2*sig(x, l))/2)+(C * pow(sin(sig(x, l)),3)));

    pts1 = concat([ for (a = [0 : L/512       : L])       [ a, y(a, R, L)         ] ], [ [ L, 0     ] ]);
    pts2 = concat([ for (a = [0 : (L-thk)/512 : (L-thk)]) [ a, y(a, R-thk, L-thk) ] ], [ [ L-thk, 0 ] ]);
    
    translate([0,0,L])
        rotate_extrude(convexity=10, $fn=128){
            rotate([0,0,-90])
                difference(){
                    polygon(pts1);
                    if(thk>0){
                        translate([thk*1.01,-0.01,0])
                            polygon(pts2);
                    }
                }
        }
}


module ellipse_cone(R=10, L=50, thk=0) {
    /*
     * R   = radius of base
     * L   = length to point
     * thk = skin thickness. 0 = solid
     */
    
    rotate_extrude(convexity=10, $fn=128){
        intersection(){
            difference(){
                resize([2*R,2*L])
                    circle(r=L, $fn=256);
                if(thk > 0){
                    resize([2*R-2*thk,2*L-2*thk])
                        circle(r=L, $fn=128);
                }
            }
            square([R,L]);
        }
    }
}


translate([20, 0]) {
    rotate([90,0,0])
        linear_extrude(height = 1, center = true, convexity = 10, twist = 0, slices = 1, scale = 1) {
            text("Tangent Ogive", font = "Liberation Sans");
        }
}
tangent_ogive_cone(R=15, L=75, rn=0, thk=1);
translate([20, 31]) {
    rotate([90,0,0])
        linear_extrude(height = 1, center = true, convexity = 10, twist = 0, slices = 1, scale = 1) {
            text("Haack", font = "Liberation Sans");
        }
}
translate([0,31,0])
    haack_cone(R=15, L=75, C=1/3, thk=1);
translate([20, 62]) {
    rotate([90,0,0])
        linear_extrude(height = 1, center = true, convexity = 10, twist = 0, slices = 1, scale = 1) {
            text("Ellipse", font = "Liberation Sans");
        }
}
translate([0,62,0])
    ellipse_cone(R=15,L=75, thk=1);