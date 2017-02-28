/**
 * BL tricopter tail motor mount
 *
 */

use <dronePlates.scad>

m3Rad = 3.1/2;
plateThick = 3;

union(){
motorRectMount(21, 18, 8);
translate([9, 10.5, 0]) {tube(m3Rad*2, 6.5, 6);}
translate([9, -10.5, 0]) {tube(m3Rad*2, 6.5, 6);}
translate([-9, 10.5, 0]) {tube(m3Rad*2, 6.5, 6);}
translate([-9, -10.5, 0]) {tube(m3Rad*2, 6.5, 6);}
}

