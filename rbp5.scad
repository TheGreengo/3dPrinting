use <common.scad>

$fn = 10;

board_w = 56.5;
board_l = 85.5;
board_r = 3.2;
case_t  = 1;
case_h  = 5;
bottm_r = 1;
htol    = 0.05;
tol     = 0.1;
pin_r   = 1.35;
pin_h   = 5;
pin_off = 2;
between = 58;
usbc_wd = 10;
usbc_of = 11.0 - (usbc_wd / 2);
usbc_hg = 3+1;
mhdmi_w = 7.5;
mhdmi_h = 3+1;
mhdm1_o = 26.8 - (usbc_wd / 2);
mhdm2_o = 40.5 - (usbc_wd / 2);
eth_h   = 10;
eth_w   = 16.75;
eth_off = 11.05 - (eth_w / 2);
usb_h   = 5;
usb_w   = 14.5;
usb2_of = 30.0 - (usb_w / 2);
usb3_of = 48.0 - (usb_w / 2);
msd_hgh = 2.5;
msd_wid = 13;
msd_len = 15;
msd_off = ((board_w + (2 * case_t)) / 2) - (msd_wid / 2);
butt_of = 21.0 - 3;
butt_h  = 1;

module top() {
    difference() {
        bottom_rrect(
            board_r+case_t,
            board_w + (2 * case_t) + tol,
            board_l + (2 * case_t) + tol,
            case_h,
            bottm_r
        );
        translate([case_t-tol, case_t-tol, case_t]) {
            rrect(board_r, board_w + tol, board_l + (tol*2), case_h);
        }
        translate([27,2.5,0])
        hex_mat_on(6,9,1,3,1);
    }
}

module bottom() {
    difference() {
        bottom_rrect(
            board_r+case_t,
            board_w + (2 * case_t) + tol,
            board_l + (2 * case_t) + tol,
            case_h,
            bottm_r
        );
        translate([case_t-tol, case_t-tol, case_t]) {
            rrect(board_r, board_w + tol, board_l + (tol*2), case_h);
        }
        
        // usb-c
        translate([usbc_of + case_t,3-tol,2*case_t])
        rotate([90,0,0])
        rrect(0.6, usbc_hg, usbc_wd, 3, false);
        // micro usb 1
        translate([mhdm1_o + case_t,3-tol,2*case_t])
        rotate([90,0,0])
        rrect(0.6, mhdmi_h, mhdmi_w, 3, false);
        // micro usb 2
        translate([mhdm2_o + case_t,3-tol,2*case_t])
        rotate([90,0,0])
        rrect(0.6, mhdmi_h, mhdmi_w, 3, false);
        // ethernet
        translate([board_l - case_t,eth_off,2*case_t])
        rotate([90,0,90])
        rrect(0.6, eth_h, eth_w, 4, false);
        // usb 3
        translate([board_l - case_t,usb2_of,2*case_t])
        rotate([90,0,90])
        rrect(0.6, usb_h, usb_w, 4, false);
        // usb 2
        translate([board_l - case_t,usb3_of,2*case_t])
        rotate([90,0,90])
        rrect(0.6, usb_h, usb_w, 4, false);
        // micro sd
        translate([-tol, msd_off,-tol])
        cube([msd_len,msd_wid,msd_hgh]);
        // pci-e mini (not in bottom)
        // fan pin hole 1
        translate([3.5+case_t,case_t + 6 + board_r,-0.1])
        cylinder(h=3,r1=2,r2=2);
        // fan pin hole 2
        translate([3.5 + case_t + between, board_w + case_t - board_r - 6.5,-0.1])
        cylinder(h=3,r1=2,r2=2);
        // gpio
        // light?
        // power button
        translate([-htol,butt_of,case_t])
        rotate([90,0,90])
        rrect(0.6, 5, 3, case_t+tol, false);
    }
    four_cols(
        v1=[3.5 + case_t, 3.5 + case_t + between],
        v2=[board_r + case_t + 0.35, board_w + case_t - 3.75],
        rots=0,
        t=0,
        r=1.35 - htol,
        h=pin_h
    );
    four_cols(
        v1=[3.5 + case_t, 3.5 + case_t + between],
        v2=[board_r + case_t + 0.35, board_w + case_t - 3.75],
        rots=0,
        t=case_t,
        r=3,
        h=case_t
    );
}

// bottom();
// top();