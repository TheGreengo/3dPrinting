use <rpz2w_no_cut.scad>
use <../common.scad>

$fn = 64;
eps = 0.5;
tol = 0.1;
nof = 0.001;

// Parameters for Raspberry Pi Zero 2 W
rpz_l  =  65 + (2 * tol);        // length
rpz_w  =  30 + (2 * tol);        // width

// Parameters for Case
case_t  = 1;                     // thickness
case_h  = 4.5;                   // case height

top_h   = 2 * (case_h / 3);      //
cam_xo  = 5.6;
cam_yo  = 32.5;
cam_pr  = 1.125;
cam_ph  = 8.0; //5.0
cam_xd  = 21.0;
cam_yd  = 12.5;

// full width is 32.2
// camera width is 25
// diff is 7.2
// offset is 3.6
// offset between center of hole and edge is 2
// offset between bottom of camera and top hole center is 14.5
// x0 = 5.6, x1 = 
// y0 = , y1 =

color("#44ff5a")
rotate([0,180,0])
translate([-rpz_w - (2 * case_t), 0, -top_h])
case_top();

for (i=[cam_xo, cam_xo + cam_xd]) {
    for (j=[cam_yo, cam_yo + cam_yd]) {
        translate([i, j, top_h - nof])
        cylinder(h=cam_ph, r=cam_pr);
    }
    for (j=[cam_yo, cam_yo + cam_yd]) {
        translate([i, j, top_h - nof])
        cylinder(h=4.0, r=cam_pr+1);
    }
}