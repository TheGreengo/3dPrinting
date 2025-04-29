include <common.scad>
include <./rpz_case/rpz2w_no_cut.scad>

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

widt = 30;
leng = 50;
widh = cos(5) * widt;
heig = sin(5) * widt;

module wll(thck, in_rad, hght, lngth, wdth) {
    doub = thck * 2;
    difference() {
        rrect(in_rad + thck, lngth + doub, wdth + doub, hght,1);
        translate([thck, thck, -(eps / 2)+1.25])
        rrect(in_rad, lngth, wdth, hght + 1 + eps);
    }
}

// Parameters:
module case_btm_ps(
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
    
    wll(bh, br, ch, bl, bw);
}

// Parameters: 
module case_btm_ng(
                co=case_co, cl=case_cl,cd=case_cd, 
                bh=case_t, ch=case_h
            ) {
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

module case_bt() {
    difference() {
        case_btm_ps();
        case_btm_ng();
    }
}

module wedge(heig, widh, leng) {
    translate([0,0,heig]) {
        rotate([0,90,0]) {
            linear_extrude(leng) {
                polygon([[0,0], [heig,widh], [heig,0]]);
            }
        }
    }
}

br=rpz_cr; bl=rpz_l; bw=rpz_w; 
bh=case_t; hr=rpz_hr; ho=rpz_ho; 
pr=case_pr; ph=case_ph; ch=case_h;

otro = rpz_l + 9;
//difference() {
//    cube([bw,bl,5]);
//    translate([bh, bh, -1.01]) {
//        // adding the pins through pins
//        for (i = [0 + ho + tol, bw - ho - tol]) {
//            for (j = [0 + ho + tol, bl - ho - tol]) {
//                translate([i, j, bh])
//                cylinder(3, pr+0.1, pr+0.1);
//            }
//        }
//    }
//}

translate([0,0,sin(5) * rpz_l + 5])
case_bt();

module base() {
    cube([bw + (2 * case_t),bl + (2 * case_t),1]);
    translate([0,0,0.99])
    wedge(sin(5) * rpz_l,rpz_l + (2 * case_t), rpz_w + (2 * case_t));
}

translate([rpz_w + (2 * case_t),0,sin(5) * rpz_l + 5]) {
    rotate([0,180,0]) {
        base();
    }
}