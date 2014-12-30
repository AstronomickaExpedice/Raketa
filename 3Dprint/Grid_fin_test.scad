	

     
     
    module circular_grid_fin(outer_d, inner_d, spacing, height, wall) {
            intersection () {
     
                    union () {
                            for (x = [0 : 9]) {
                                    translate([-(outer_d / 2) + x * spacing, -(outer_d / 2), 0])
                                    cube([wall, outer_d, height]);
                            }
     
                            for (y = [0 : 9]) {
                                    translate([-(outer_d / 2), -(outer_d / 2) + y * spacing, 0])
                                    cube([outer_d, wall, height]);
                            }
                    }
     
                    difference () {
                            cylinder(r = outer_d / 2, h = height);
                            translate([0, 0, -(height / 2)])
                            cylinder(r = inner_d / 2, h = height * 2);
                    }
     
            }
           
            difference () {
                    cylinder(r = outer_d / 2, h = height);
                   
                    translate([0, 0, -(height / 2)])
                    cylinder(r = (outer_d / 2) - wall, h = height * 2);
            }
    }
     
     
    circular_grid_fin(100, 50, 10, 10, 1);

