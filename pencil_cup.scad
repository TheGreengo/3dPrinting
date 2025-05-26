use <doodle.scad>
$fn = 200;

difference() {
    for (i = [0:20]) {
        rotate([0, 0, 18 * i])
        linear_extrude(height = 100, center = false, convexity = 10, twist = 90, slices = 100)
        translate([35, 0, 0])
        ellipse(4, 4, 200);

        rotate([0, 0, 18 * i])
        linear_extrude(height = 100, center = false, convexity = 10, twist = -90, slices = 100)
        translate([35, 0, 0])
        ellipse(4, 4, 200);
    }
    translate([0,0,95.1])
    cylinder(h=10,r1=40,r2=40);
}

cylinder(h=1,r1=37,r2=37);

translate([0,0,95]) {
    difference() {
        cylinder(h=1,r1=37,r2=37);
        translate([0,0,-0.25])
        cylinder(h=1.5,r1=33,r2=33);
    }
}

// Thoughts on my "widening" idea:
// - draw elipses
// - make a "layer" (a set of ellipses in a ring)
// - make a series of layers
//   - such that it widens
//   - such that they are at an angle (tilting away from middle)
