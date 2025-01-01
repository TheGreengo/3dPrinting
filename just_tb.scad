// The Toothbrush and toothpaste holder thingy
$fa = 1;
$fs = 0.4;

// The Sum of All of the (non-negative) Components
module positive() {
    // Baseplate
    cube([36,36,5]);
    // Up part for charger
    color("blue")
    translate([0,0,0])
    // Up part for toothbrush one
    color("green")
    translate([18,18,0])
    cylinder(r=18,h=15);
}

difference() {
    // Charger cutout
    positive();
    // Toothbrush one cutout
    translate([18,18,2])
    cylinder(r=16,h=20);
    translate([0,10,10])
    cube([4,15,10]);
}