/**
 * cinetank plate for zip-tie fpv cam mount
 */

use <dronePlates.scad>

m3Rad = 3.6/2;
plateThick = 6;
holeDist=53.5;

difference() {

union(){
roundedRect([holeDist+6,7,plateThick], 3);

}//union

translate([-21.5,-5,-0.5]) cube([43,10,4.5]);

for(i=[-1,1]){
translate([i*6,0,-0.5]) slot(4, 10, m3Rad);
translate([i*holeDist/2,0,-0.5]) cylinder(h = plateThick+1, r = m3Rad, $fn=30);
}

} //diff


