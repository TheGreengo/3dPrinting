$fn = 500;
eps = 0.5;
tol = 0.1;

module base(radius, length, width, height) {
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

// Parameters for Raspberry Pi Zero 2 W
rpz_cr =  3;                     // corner radius
rpz_l  =  65.2;                    // length
rpz_w  =  30.2;                    // width
rpz_hr =  2.75 / 2;              // hole radius
rpz_ho =  3.5;                   // hole offset

// Parameters for Case
case_ph = 4.5;                     // through-pin height
case_pr = rpz_hr - tol;          // through-pin radius
case_co = 6.5;                     // pin cutout offset
case_cl = 52;                    // pin cutout length
case_cd = 7;                     // pin cutout depth
case_t  = 1;                     // thickness
case_h  = 4.5;                     // case height
pci_o   = 6;                   // offset of pci slot
pci_l   = rpz_w - (2 * pci_o);   // width of pci slot
hdmi_o  = 6.6;                   // mini HDMI offset
hdmi_w  = 12.5;                  // mini HDMI width
usb1_o  = 37.0;                  // micro USB 2 offset
usb2_o  = 50;                    // micro USB 2 offset
usb_w   = 8.5;                     // micro USB cutout width
sd_o    = 6.5;
sd_w    = 13;

module wall(thck, in_rad, hght, lngth, wdth) {
    doub = thck * 2;
    difference() {
        base(in_rad+thck, lngth + doub, wdth + doub, hght);
        translate([thck, thck, -(eps / 2)])
        base(in_rad, lngth, wdth, hght + eps);
    }
}

// Parameters:
module case_btm_pos (br, bl, bw, bh, hr, ho, pr, ph, ch) {
    translate([bh, bh, 0]) {
        // adding the pins through pins
        for (i = [0 + ho, bw - ho]) {
            for (j = [0 + ho, bl - ho]) {
                color("green")
                translate([i, j, bh])
                cylinder(ph, pr, pr);
            }
        }
        
        base(br, bl, bw, bh);
    }
    
    wall(bh, br, ch, bl, bw);
}

// Parameters: 
module case_btm_neg(co, cl, cd, bh, ch) {
    translate([0 - eps, 0 + co + bh, -(eps / 2)])
    cube([cd + eps, cl, ch + eps]);
    translate([pci_o + bh, rpz_l, bh + 0.001])
    cube([pci_l,10,10]);
    translate([sd_o + bh, -eps, bh + 0.001])
    cube([sd_w,10,10]);
    translate([5,hdmi_o + bh,bh + 0.001])
    cube([rpz_w,hdmi_w,5]);
    translate([5,usb1_o + bh,bh + 0.001])
    cube([rpz_w,usb_w,5]);
    translate([5,usb2_o + bh,bh + 0.001])
    cube([rpz_w,usb_w,5]);
}

module case_btm(br, bl, bw, bh, hr, ho, pr, ph, co, cl, cd, ch) {
    difference() {
        case_btm_pos(br, bl, bw, bh, hr, ho, pr, ph, ch);
        case_btm_neg(co, cl, cd, bh, ch);
    }
}

case_btm(rpz_cr, rpz_l, rpz_w, case_t, 
         rpz_hr, rpz_ho, case_pr, case_ph,
         case_co, case_cl, case_cd, case_h);
         
// TODO: make modules have preset values to simplify
// TODO: make variable for the teensy offset for negative surfaces
// TODO: filleted edges for cutouts
// TODO: update cutouts with values from prototype
// TODO: round bottom edge
// TODO: make top case part
// TODO: make click together thing
// TODO: make bambu studio profile
// TODO: upload to makerworld.com
         
         
         
         
         
         
         
         