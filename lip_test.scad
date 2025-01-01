$fn = 32;

difference() {
    cube([20,20,8]);
    translate([1.5,1.5,1])
    cube([17,17,18]);
    translate([0.5,0.5,6])
    cube([19,19,9]);
}

module thing() {
    intersection() {
        cube([20,20,8]);
        translate([1,1,6])
        cube([18,18,2]);
    }
}

translate([32,0,0])
difference() {
    thing();
    translate([1.5,1.5,0])
    cube([17,17,20]);
}


translate([32,0,0])
difference() {
    cube([20,20,6]);
    translate([1.5,1.5,1])
    cube([17,17,8]);
    //translate([0.5,0.5,6])
    //cube([9,9,9]);
}

// Left in
translate([0,0.5,7.6])
rotate([0,90,0])
cylinder(h=20,r1=0.2, r2=0.2);

// Right in
translate([0,19.5,7.6])
rotate([0,90,0])
cylinder(h=20,r1=0.2, r2=0.2);

// Top in 
translate([0.5,0,7.6])
rotate([0,90,90])
cylinder(h=20,r1=0.2, r2=0.2);

// Bottom in
translate([19.5,0,7.6])
rotate([0,90,90])
cylinder(h=20,r1=0.2, r2=0.2);

// Left out
translate([33.5,1,7.6])
rotate([0,90,0])
cylinder(h=17,r1=0.4, r2=0.4);

// Right out
translate([33.5,19,7.6])
rotate([0,90,0])
cylinder(h=17,r1=0.4, r2=0.4);

// Top out
translate([33,1.5,7.6])
rotate([0,90,90])
cylinder(h=17,r1=0.4, r2=0.4);

// Bottom out
translate([51,1.5,7.6])
rotate([0,90,90])
cylinder(h=17,r1=0.4, r2=0.4);

//color("red")
//translate([32.5,0.5,7])
//cube(1);