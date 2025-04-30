//include <../common.scad>

$fn = 64;
eps = 0.5;
tol = 0.1;
nof = 0.001;

// Parameters for Raspberry Pi Zero 2 W
rpz_cr =  3;                     // corner radius
rpz_l  =  65 + (2 * tol);        // length
rpz_w  =  30 + (2 * tol);        // width
rpz_hr =  2.75 / 2;              // hole radius
rpz_ho =  3.5;                   // hole offset

// Parameters for Case
case_ph = 4.5;                   // through-pin height
case_pr = rpz_hr - tol;          // through-pin radius
case_co = 6.5;                   // pin cutout offset
case_cl = 52;                    // pin cutout length
case_cd = 7;                     // pin cutout depth
case_t  = 1;                     // thickness
case_h  = 4.5;                   // case height
pci_o   = 6;                     // offset of pci slot
pci_l   = rpz_w - (2 * pci_o);   // width of pci slot
hdmi_o  = 6.4;                   // mini HDMI offset
hdmi_w  = 12.5;                  // mini HDMI width
usb1_o  = 37.1;                  // micro USB 2 offset
usb2_o  = 49.95;                 // micro USB 2 offset
usb_w   = 8.5;                   // micro USB cutout width
sd_o    = 6.5;                   // 
sd_w    = 13;                    // 
top_h   = 2*(case_h/3);          //


module donut(inner_radius, body_radius) {
    rotate_extrude(convexity=10)
    translate([inner_radius,0,0])
    circle(r=body_radius);
}

// cuboid with chamfored edges on the bottom
module bottom_rrect(radius, width, length, height, bradius) {
    // Vertical columns
    translate([radius,radius,bradius])
    cylinder(r=radius, h=height-bradius);
    translate([length-radius,radius,bradius])
    cylinder(r=radius, h=height-bradius);
    translate([radius,width-radius,bradius])
    cylinder(r=radius, h=height-bradius);
    translate([length-radius,width-radius,bradius])
    cylinder(r=radius, h=height-bradius);
    // Things
    translate([radius,bradius,bradius])
    rotate([0,90,0])
    cylinder(r=bradius, h=length-(2*radius));
    translate([radius,width-bradius,bradius])
    rotate([0,90,0])
    cylinder(r=bradius, h=length-(2*radius));
    // Stuff
    rotate([90,0,0])
    translate([bradius,bradius,-width+radius])
    cylinder(r=bradius, h=width-(2*radius));
    rotate([90,0,0])
    translate([length-bradius,bradius,-width+radius])
    cylinder(r=bradius, h=width-(2*radius));
    
    translate([radius,radius,bradius])
    donut(radius-bradius, bradius);
    translate([radius,radius,0])
    cylinder(r=radius-bradius, h=bradius);
    translate([length-radius,radius,bradius])
    donut(radius-bradius, bradius);
    translate([length-radius,radius,0])
    cylinder(r=radius-bradius, h=bradius);
    translate([radius,width-radius,bradius])
    donut(radius-bradius, bradius);
    translate([radius,width-radius,0])
    cylinder(r=radius-bradius, h=bradius);
    translate([length-radius,width-radius,bradius])
    donut(radius-bradius, bradius);
    translate([length-radius,width-radius,0])
    cylinder(r=radius-bradius, h=bradius);
    
    // "upper" filler cubes
    translate([radius,0,bradius])
    cube([length-(2*radius),width,height-bradius]);
    translate([0,radius,bradius])
    cube([length,width-(2*radius),height-bradius]);
    
    // "Lower" filler cubes
    translate([radius,bradius,0])
    cube([length-(2*radius),width-(2*bradius),bradius]);
    translate([bradius,radius,0])
    cube([length-(2*bradius),width-(2*radius),bradius]);
}

// cuboid where corners on one axis are rounded
module rrect(radius, length, width, height, vert=false) {
    // width is x-axis, length is y-axis
    w_space = width - (2 * radius);
    l_space = length - (2  * radius);
    for (i = [0, w_space]) {
        for (j = [0, l_space]) {
            translate([i+radius,j+radius,0])
            cylinder(height, radius, radius);
        }
    }
    translate([radius,0,0])
    cube([w_space,length,height]);
    translate([0,radius,0])
    cube([width,l_space,height]);
}


module wall(thck, in_rad, hght, lngth, wdth) {
    doub = thck * 2;
    difference() {
        bottom_rrect(in_rad + thck, lngth + doub, wdth + doub, hght,1);
        translate([thck, thck, -(eps / 2)+1.25])
        rrect(in_rad, lngth, wdth, hght + 1 + eps);
    }
}

// Parameters:
module case_btm_pos(
                br=rpz_cr, bl=rpz_l, bw=rpz_w, 
                bh=case_t, hr=rpz_hr, ho=rpz_ho, 
                pr=case_pr, ph=case_ph, ch=case_h
            ) {
    translate([bh, bh, 0]) {
        // adding the pins through pins
        for (i = [0 + ho + tol, bw - ho - tol]) {
            for (j = [0 + ho + tol, bl - ho - tol]) {
                translate([i, j, bh])
                cylinder(ph+top_h-bh + tol, pr, pr);
            }
        }
    }
    
    wall(bh, br, ch, bl, bw);
}

// Parameters: 
module case_btm_neg(
                co=case_co, cl=case_cl,cd=case_cd, 
                bh=case_t, ch=case_h
            ) {
    translate([0 - eps, 0 + co + bh, -(eps / 2)])
    cube([cd + eps, cl, ch+1 + eps]);
    translate([pci_o + bh, rpz_l, bh + nof])
    cube([pci_l,10,10]);
    translate([sd_o + bh, -eps, bh + nof])
    cube([sd_w,10,10]);
    translate([5,hdmi_o + bh,bh + nof])
    cube([rpz_w,hdmi_w,5]);
    translate([5,usb1_o + bh,bh + nof])
    cube([rpz_w,usb_w,5]);
    translate([5,usb2_o + bh,bh + nof])
    cube([rpz_w,usb_w,5]);
}

module case_btm() {
    difference() {
        case_btm_pos();
        case_btm_neg();
    }
}
// (2 * case_t) + rpz_l
module case_top() {
    basis = case_t + rpz_l;
    difference() {
        wall(case_t, rpz_cr, top_h, rpz_l, rpz_w);
        translate([-eps, basis-case_co-case_cl,-(eps/2)])
        cube([case_cd + eps, case_cl, case_h+1 + eps]);
        translate([case_t, case_t, 0]) {
            // adding the pins through pins
            for (i = [rpz_ho+tol,rpz_w-rpz_ho-tol]) {
                for (j = [rpz_ho+tol,rpz_l-rpz_ho-tol]) {
                    translate([i, j, -nof])
                    cylinder(case_ph, case_pr+0.1, case_pr+0.1);
                }
            }
        }
        translate([5,basis - hdmi_o - hdmi_w,case_t + nof])
        cube([rpz_w,hdmi_w,5]);
        translate([5,basis - usb1_o - usb_w,case_t + nof])
        cube([rpz_w,usb_w,5]);
        translate([5,basis - usb2_o - usb_w,case_t + nof])
        cube([rpz_w,usb_w,5]);
    }
}

// (2 * case_t) + rpz_l
module case_top_snug() {
    basis = case_t + rpz_l;
    difference() {
        wall(case_t, rpz_cr, top_h, rpz_l, rpz_w);
        translate([-eps, basis-case_co-case_cl,-(eps/2)])
        cube([case_cd + eps, case_cl, case_h+1 + eps]);
        translate([case_t, case_t, 0]) {
            // adding the pins through pins
            for (i = [rpz_ho+tol,rpz_w-rpz_ho-tol]) {
                for (j = [rpz_ho+tol,rpz_l-rpz_ho-tol]) {
                    translate([i, j, -nof])
                    cylinder(case_ph, case_pr+0.05, case_pr+0.05);
                }
            }
        }
        translate([5,basis - hdmi_o - hdmi_w,case_t + nof])
        cube([rpz_w,hdmi_w,5]);
        translate([5,basis - usb1_o - usb_w,case_t + nof])
        cube([rpz_w,usb_w,5]);
        translate([5,basis - usb2_o - usb_w,case_t + nof])
        cube([rpz_w,usb_w,5]);
    }
}

color("#44ff5a")
case_btm();
color("green")
translate([35, 0, 0])
case_top_snug();
         