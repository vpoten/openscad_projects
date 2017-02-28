/**
 * ramps fan plate
 */

use <dronePlates.scad>

m3Rad = 3.6/2;
m4Rad = 4.6/2;
fanHoles = 71.5;
plateThick = 2.25;

difference(){

union(){
roundedRect([87,87,plateThick],4);
}//union

translate([0,0,-0.5]) cylinder(h = plateThick+1, r = 80/2, $fn=40);

translate([82/2-2,48/2,-0.5]) cylinder(h = plateThick+1, r = m3Rad, $fn=30);

for(i=[-1,1]) translate([i*82/2,-48/2,-0.5]) cylinder(h = plateThick+1, r = m3Rad, $fn=30);

for(i=[-1,1]) for(j=[-1,1]) translate([i*fanHoles/2,j*fanHoles/2,-0.5]) cylinder(h = plateThick+1, r = m4Rad, $fn=30);
}//diff
