use <../common.scad>

$fn = 12;
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

bot_of_top = 35 + rpz_ho + tol + case_t + rpz_hr + 1;
top_of_bot = 35 + rpz_w + case_t - rpz_ho - rpz_hr - 1;
hole_right = case_t + rpz_ho + rpz_hr + 2;
hole_left  = rpz_l - case_t - rpz_hr - rpz_ho;

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

module case_top() {
    basis = case_t + rpz_l;
    difference() {
        wall(case_t, rpz_cr, top_h, rpz_l, rpz_w);
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

hex_ta = 2.09;
hex_th = 1;
dumb   = (hex_ta - hex_th) * 2;
mid_rows = 11;
mid_cols = 16;
l_rows = 7;
l_cols = 2;
dims = hex_dim(hex_ta);
ndims = hex_dim(hex_ta+hex_th);
l_off = hole_right - (2 * dumb) - (2 * hex_th);
r_off = hole_right + (mid_cols * (dumb + hex_th));
f_off = hex_row_yoff(hex_ta + hex_th, hex_ta) + (2 * case_t);
//color("#44ff5a")
difference(){
    case_btm();
    translate([case_t, hole_right, -nof])
    hex_diff(mid_rows,mid_cols,hex_th,hex_ta,2);
    translate([f_off, l_off, -nof])
    hex_diff(l_rows,l_cols,hex_th,hex_ta,2);
    translate([f_off, r_off, -nof])
    hex_diff(l_rows,l_cols,hex_th,hex_ta,2);
}

//color("greenyellow")
//difference() {
//    translate([35, 0, 0])
//    case_top();
//    translate([case_t + 35, hole_right, -nof])
//    hex_diff(10,15,1,2.09,2);
//}