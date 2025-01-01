// Thing stuff case-ifier
case_thick  =   2.5;
case_width  = 175.0;
case_height =  80.0;
inner_width = case_width - (2 * case_thick);
inner_thick =   1.0;
inner_off   = 2 * inner_thick;

module compartment(sizes, start) {
    if (start[2] != 0) {
    }
    //cube();
    translate([for (i=[0:2]) start[i] + case_thick - inner_thick])
    difference() {
        cube(sizes);
        translate([inner_thick, inner_thick, inner_thick])
        cube([sizes[0] - inner_off, sizes[1] - inner_off, case_height]);
    }
}

difference(){
    cube([case_width,case_width,case_height]);
    translate([case_thick, case_thick, case_thick])
    cube([inner_width,inner_width, case_height]);
    //compartment([30,30,30],[0,0,0]);
}

compartment([30,30,30],[0,0,0]);