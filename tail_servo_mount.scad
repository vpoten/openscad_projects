/**
 * BL tricopter tail servo mount
 *
 */

use <dronePlates.scad>

m3Rad = 3.1/2;
plateThick = 3;
holesXd = 30;
holesYd = 50;

difference(){
union(){
hShapePlate(holesYd, holesXd);
translate([-4,-25,0]){cube(size = [8,50,plateThick]);}
rotate([0, 0, 45]) {motorCircleMount(8, 35);}
translate([holesXd/2, holesYd/2, 0]) {tube(m3Rad*2, 6.5, 6);}
translate([holesXd/2, -holesYd/2, 0]) {tube(m3Rad*2, 6.5, 6);}
translate([-holesXd/2, holesYd/2, 0]) {tube(m3Rad*2, 6.5, 6);}
translate([-holesXd/2, -holesYd/2, 0]) {tube(m3Rad*2, 6.5, 6);}
}
cylinder(h = 10, r = 4, $fn=100, center=true);
}

translate([40, 0, 0]) {scale([1,1,1.5]){motorCircleMount(8, 40);}}
