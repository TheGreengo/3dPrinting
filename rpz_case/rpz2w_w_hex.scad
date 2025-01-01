use <../common.scad>
use <rpz2w_no_cut.scad> 

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

bot_of_top = 35 + rpz_ho + tol + case_t + rpz_hr + 1;
top_of_bot = 35 + rpz_w + case_t - rpz_ho - rpz_hr - 1;
hole_right = case_t + rpz_ho + rpz_hr + 1;
hole_left  = 0;

module hexadron(tall, height) {
    wide   = tall / tan(60);
    radius = sqrt((tall ^ 2) + (wide ^ 2));
    linear_extrude(height) {
        polygon(
            [[tall, 0], [2 * tall, wide], [2 * tall, wide + radius],
            [tall, (2 * wide) + radius], [0, wide + radius],[0, wide]]
        );
    }
}

module hex_tile(tall, height, width) {
    // we want 
    // opp / adj = tan(60)
    // 2x^2 = 1
    del = width * tan(50);
    echo(tan(50));
    difference() {
        hexadron(tall, height);
        translate([width, del, -nof])
        hexadron(tall-width, height + (2 * nof));
    }
}

module protected() {
}

//color("red")
//translate([bot_of_top, case_t, 0])
//cube([top_of_bot -  bot_of_top, hole_right - case_t, 2]);
//color("purple")
//translate([bot_of_top, hole_right, 0])
//cube([top_of_bot -  bot_of_top, hole_right - case_t, 2]);

//color("#44ff5a")
//case_btm();

//color("greenyellow")
//translate([35, 0, 0])
//case_top();

hex_tile(5, 2.5, 1);