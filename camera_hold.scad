use <rpz_case/rpz2w_case.scad>

$fn = 25;

thk = 4.5 + 2*(4.5/3)+0.1;

module cas() {
    color("#44ff5a")
    case_btm();
    color("green")
    translate([0,65.2 + 2,4.5 + 2*(4.5/3)+0.1])
    rotate([0,180,180])
    case_top_snug();
}

translate([40,5,71.25])
rotate([90,180,180])
cas();

cube([80,30,2]);

module case_holder() {
    // down under
    translate([39.5,4.85,0])
    cube([7.1,thk + 0.3,4]);
    translate([65.5,4.85,0])
    cube([8,thk + 0.3,4]);

    // front
    translate([37.8,2.9,0])
    cube([8.8,2,20]);
    translate([65.5,2.9,0])
    cube([8.95,2,20]);

    // back
    translate([37.8,thk + 5.1,0])
    cube([8.8,2,20]);
    translate([65.5,thk + 5.1,0])
    cube([8.95,2,20]);

    // left
    translate([37.8,4.85,0])
    cube([2,thk + 0.3,20]);

    // right
    translate([72.45,4.85,0])
    cube([2,thk + 0.3,20]);
}

case_holder();