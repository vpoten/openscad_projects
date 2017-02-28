/**
 * alien bumper
 */

use <dronePlates.scad>;

holeDist = 29;
m3Rad = 3.3/2;
thick = 3;
width = 38;
length = 11;
holeShift = 0;


//translate([0,20,0]) cube(size=[width,2,2], center=true);

difference(){
hull(){
    roundedRect([width-3,length-3,thick], 3);
    translate([0,3,0]) cylinder(r=5, h=thick, $fn=20);
}

for(i=[-1,1]){
translate([i*holeDist/2, holeShift, -0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
translate([i*holeDist/2, holeShift, thick/2]) cylinder(r=m3Rad*2, h=thick/2, $fn=20);
}

}