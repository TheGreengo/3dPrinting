// The Toothbrush and toothpaste holder thingy
/*
Measurements:
- toothpaste width: 55 mm
- Toothbrush radius: 31 mm
- Charger length: 54 mm
- Charger width: 41 mm
- Charger height: 22 mm
- Charge cord width: 7 mm
*/
$fa = 1;
$fs = 0.4;

// Charger Cutout
module ch_cut(leng, radi, hei) {
    cube([leng,2*radi,hei]);
    translate([leng,radi,0])
    cylinder(r=radi,h=hei);
}

// Toothbrush Cutout
module tb_cut() {
    cube([60,10,10]);
}

// The Sum of All of the (non-negative) Components
module positive() {
    // Baseplate
    cube([37.5,176,5]);
    // Up part for toothbrush one
    color("green")
    translate([17.5,17.5,0])
    cylinder(r=17.5,h=15);
    // Up part for toothbrush two
    color("purple")
    translate([17.5,55,0])
    cylinder(r=17.5,h=15);
    // Up part for toothpaste one
    color("blue")
    translate([0,76,0])
    cube([37.5,50,100]);
    // Up part for toothpaste two
    color("green")
    translate([0,126,0])
    cube([37.5,50,100]);
}

difference() {
    positive();
    translate([17.5,17.5,2])
    cylinder(r=15.5,h=20);
    // Toothbrush two cutout
    translate([17.5,55,2])
    cylinder(r=15.5,h=20);
    // Toothpaste one cutout
    translate([2,78,2])
    cube([33.5,47,200]);
    // Toothpast two cutout
    translate([2,127,2])
    cube([33.5,47,200]);
    
}