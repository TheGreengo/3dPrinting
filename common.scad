$fn=50;

module donut(inner_radius, body_radius) {
    rotate_extrude(convexity=10)
    translate([inner_radius,0,0])
    circle(r=body_radius);
}

// helper module for making sets of columns
module four_cols(v1, v2, rots, t, r, h) {
    for (i = v1, j = v2) {
        rotate(rots)
        translate([i, j, t])
        cylinder(r = r, h = h);
    }
}

// cuboid with filleted edges on the bottom
module bottom_rrect(radius, width, length, height, bradius) {
    // Vertical columns
    for (i = [radius, length - radius]) {
        for (j = [radius, width - radius]) {
            translate([i, j, bradius])
            cylinder(r=radius, h=height-bradius);
            
            translate([i, j, bradius])
            donut(radius-bradius, bradius);
            
            translate([i, j, 0])
            cylinder(r=radius-bradius, h=bradius);
        }
    }

    // x-axis cylinders
    four_cols([-bradius], [bradius, width-bradius], [0,90,0], radius, bradius, length-(2*radius));
    
    // y-axis cylinders
    color("red")
    four_cols([length, bradius], [bradius],[90,0,0], radius, bradius, -width + radius);
    four_cols([bradius, length - bradius], [bradius], [90,0,0], -width + radius, bradius, width - (2 * radius));
   
    // top fill cuboids
    translate([radius,0,bradius])
    cube([length-(2*radius), width, height-bradius]);
    translate([0,radius,bradius])
    cube([length, width-(2*radius), height-bradius]);
    
    // bottom fill cuboids
    translate([radius,bradius,0])
    cube([length-(2*radius), width-(2*bradius), bradius]);
    translate([bradius,radius,0])
    cube([length-(2*bradius), width-(2*radius), bradius]);
}

// cuboid where corners on one axis are rounded
module rrect(radius, length, width, height, vert=false) {
    // width is x-axis, length is y-axis
    w_space = width - (2 * radius);
    l_space = length - (2  * radius);
    for (i = [0, w_space], j = [0, l_space]) {
        translate([i+radius, j+radius, 0])
        cylinder(height, radius, radius);
    }
    translate([radius, 0, 0])
    cube([w_space, length, height]);
    translate([0,radius, 0])
    cube([width, l_space, height]);
}


// cuboid that is fully rounded all around
module full_rrect(radius, length, width, height) {
    translate([radius, radius, radius]) {
        four_cols([0, length], [0, width], [0, 0, 0], 0, radius, height);
        four_cols([0, -height],[0, width],[0, 90, 0], 0, radius, length);
        four_cols([0, length],[0, height],[90, 0, 0],-width,radius,width);
    
        for (i = [0, length], j = [0, width], k = [0, height]) {
            translate([i, j, k])
            sphere(radius);
        }
        
        translate([0,0,-radius])
        cube([length, width, height+(2*radius)]);
        translate([0,-radius,0])
        cube([length, width+(2*radius), height]);
        translate([-radius,0,0])
        cube([length+(2*radius), width, height]);
    }
}

bottom_rrect(3, 36, 24, 2, 1);
