dept = 12;
heig = 100;
widt = 108;

echo((176 - 2) / (dept + 2));

module bottom() {
    difference() {
        cube([112,170,80]);
        for (i = [0:11]) {
            translate([2,(i * 14) + 2,1]) {
                cube([widt,12,30]);
            }
        }
        translate([2,2,20]) {
            cube([widt,166,70]);
        }
    }
}

module top() {
    translate([150,0,0]) {
        difference() {
            cube([117,175,10]);
            translate([2,2,2]) {
                cube([113,171,10]);
            }
            for (i = [0:11]) {
                translate([4,(i * 14) + 4,-0.1]) {
                    cube([widt,12,30]);
                }
            }
        }
    }
}

module mold() {
    difference() {
        cube([117,15.5,170]);
        translate([2,2,2]) {
            cube([113,11.5,170]);
        }
    }
}


module tring(leng, thick) {
    translate([0,0,leng]) {
        rotate([90,210,180]) {
            linear_extrude(thick) {
                circle(r=leng, $fn = 3);
            }
        }
    }
}

module fridge_box() {
    difference() {
        cube([112,172,80]);
        for (i = [0:9]) {
            translate([2,(i * 17) + 2,1]) {
                cube([widt,15,90]);
            }
        }
        translate([56,2,12])
        tring(65, 160);
    }
}

//bottom();
fridge_box();