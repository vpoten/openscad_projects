/**
 * lt210 bumper
 */

use <dronePlates.scad>;

holeDist = 28;
m3Rad = 3.3/2;
thick = 3;
width = 37;
length = 11;
holeShift = 0;


//translate([0,20,0]) cube(size=[width,2,2], center=true);

difference(){
roundedRect([width-3,length-3,thick], 3);

for(i=[-1,1]){
translate([i*holeDist/2, holeShift, -0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
translate([i*holeDist/2, holeShift, thick/2]) cylinder(r=m3Rad*2, h=thick/2, $fn=20);
}

}