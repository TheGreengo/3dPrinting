use <../common.scad>
use <rpz2w_no_cut.scad>

$fn = 64;
eps = 0.5;
tol = 0.1;
nof = 0.001;

// Parameters for Raspberry Pi Zero 2 W
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

bot_of_top = 35 + rpz_ho + tol + case_t + rpz_hr + 1;
top_of_bot = 35 + rpz_w + case_t - rpz_ho - rpz_hr - 1;
hole_right = case_t + rpz_ho + rpz_hr + 2;
hole_left  = rpz_l - case_t - rpz_hr - rpz_ho;

hex_ta = 2.09;
hex_th = 1;
dumb   = (hex_ta - hex_th) * 2;
mid_rows = 11;
mid_cols = 16;
l_rows = 7;
l_cols = 2;
dims = hex_dim(dumb);
ndims = hex_dim(hex_ta+hex_th);
odims = hex_dim(hex_ta-hex_th);
l_off = hole_right - (2 * dumb) - (2 * hex_th);
r_off = hole_right + (mid_cols * (dumb + hex_th));
f_off = hex_row_yoff(hex_ta + hex_th, hex_ta) + (2 * case_t);
bad_1 = -odims[2] - case_t - hex_row_yoff(hex_ta, hex_ta - hex_th);
bad_2 = hole_right - (hex_row_xoff(hex_ta, hex_th) / 2);
bad_3 = bad_1 - (8 * hex_row_yoff(hex_ta, hex_ta - hex_th));
bad_4 = hole_right + (16 * hex_row_xoff(hex_ta, hex_th));
bad_5 = -case_t - odims[2];
bad_6 = hole_right + (16 * hex_row_xoff(hex_ta, hex_th));
bad_7 = -case_t - odims[2] - (10 * hex_row_yoff(hex_ta, hex_ta - hex_th));

module neg_hexes() {
    translate([case_t, hole_right, -nof])
    hex_diff(mid_rows,mid_cols,hex_th,hex_ta,2);
    translate([f_off, l_off, -nof])
    hex_diff(l_rows,l_cols,hex_th,hex_ta,2);
    translate([f_off, r_off, -nof])
    hex_diff(l_rows,l_cols,hex_th,hex_ta,2);
    rotate([0,0,90])
    translate([bad_2, bad_1, -nof])
    hexadron(dumb/2, 2);
    rotate([0,0,90])
    translate([bad_2, bad_3, -nof])
    hexadron(dumb/2, 2);
    rotate([0,0,90])
    translate([bad_4, bad_5, -nof])
    hexadron(dumb/2, 2);
    rotate([0,0,90])
    translate([bad_6, bad_7, -nof])
    hexadron(dumb/2, 2);
}

//color("#44ff5a")
difference(){
    case_btm();
    neg_hexes();
}