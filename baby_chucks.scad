// hyp = sqrt(40^2 + 70^2);
// ang = atan(40/70);

// difference() {
//     cube([40,70,40]);
//     translate([-0.05,-0.05,40])
//     rotate([-ang,0,0])
//         cube([41,hyp+1,40+1]);
// }

steps = 500;
leng  = 70;
high  = 35;

function slope (x) = (1 / (x + 0.5)) - 0.25;

thing = [for (i = [0:steps]) [i * (leng / steps), (80 / 3.5) * slope((i * (leng / steps)) / 20)] ];
echo(thing);

module baby_chuck() {
    rotate([90,0,0]){
        linear_extrude(40) {
            polygon(concat([[0,0]], thing, [[7,0]]));
        }
    }
}

module combined_chuck() {
union() {
    baby_chuck();

    translate([172,-40,0]) {
        rotate([0,0,180]) {
            baby_chuck();
        }
    }
    translate([0,-40,0]) {
        cube([172,40,0.25]);
    }
}
}

$fn = 50;
difference() {
    minkowski(){
        combined_chuck();
        sphere(2.5);
    }
    translate([-2.5,-45,-3.5])
    cube([180,50,5]);
}

