$fn=50;
nof = 0.001;

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

function hex_wid(x) = x / tan(60);

function hex_rad(x) = sqrt((x ^ 2) + (hex_wid(x) ^ 2));

function hex_ful(x) = (2 * hex_wid(x)) + hex_rad(x);

function hex_dim(x) = [hex_wid(x), hex_rad(x), hex_ful(x)];

module hexadron(tall, height) {
    wide   = hex_wid(tall);
    radius = hex_rad(tall);
    linear_extrude(height) {
        polygon(
            [[tall, 0], [2 * tall, wide], [2 * tall, wide + radius],
            [tall, (2 * wide) + radius], [0, wide + radius],[0, wide]]
        );
    }
}

module hex_tile(tall, height, thick) {
    // A whole bunch of trig garbage, there's probably a better way
    ntall  = tall - thick;
    ndims  = hex_dim(ntall);
    dims   = hex_dim(tall);
    wide   = hex_wid(tall);
    radius = hex_rad(tall);
    del    = (dims[2] - ndims[2]) / 2;
    
    difference() {
        hexadron(tall, height);
        translate([thick, del, -nof])
        hexadron(ntall, height + (2 * nof));
    }
}

function hex_row_xoff(tall, thick) = (2 * tall) - thick;
function hex_row_int_h(thick)      = sqrt(thick^2 - (thick / 2)^2);
function hex_row_h1(tall, ntall)   = (hex_ful(tall) - hex_ful(ntall)) / 2;
function hex_row_h2(tall, ntall)   = hex_wid(ntall) + 
                                     hex_row_h1(tall, ntall) -
                                     hex_row_int_h(ntall - tall);
function hex_row_yoff(tall, ntall) = hex_ful(tall) - 
                                     hex_row_h1(tall, ntall) - 
                                     hex_row_h2(tall, ntall);
                                     
module hex_mat(rows, cols, thick, tall, height) {
    ntall  = tall - thick;
    dims   = hex_dim(tall);
    ndims  = hex_dim(ntall);
    xoff   = hex_row_xoff(tall, thick);
    yoff   = hex_row_yoff(tall, ntall);
    
    for (i = [0:cols], j = [0:rows]) {
        odd = (j % 2) * (tall - (thick / 2));
        rotate([0,0,90])
        translate([(xoff * i) + odd, -dims[2] - (j * yoff), 0])
        hex_tile(tall, height, thick);
    }
}

// ok, I want to make it so 
module hex_diff(rows, cols, thick, tall, height, oddf=false, eh=false) {
    ntall  = tall - thick;
    dims   = hex_dim(tall);
    ndims  = hex_dim(ntall);
    xoff   = hex_row_xoff(tall, thick);
    yoff   = hex_row_yoff(tall, ntall);
    oddadj = oddf ? 1 : 0;
    
    for (i = [0:(cols-1)], j = [0:(rows-1)]) {
        odd = ((j + oddadj) % 2) * (tall - (thick / 2));
        rotate([0,0,90])
        translate([(xoff * i) + odd, -ndims[2] -(j * yoff), 0])
        hexadron(tall - thick, height);
    }
    
    if (eh) {
        for (i = [0:rows]) {
            if ((i + oddadj) % 2 == 0) {
            }
        }
    }
}