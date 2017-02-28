/**
 * xj470 arm drill guide
 */

use <dronePlates.scad>


tubeD = 16.7;
m25Rad = 2.8/2;
distA1 = 15;
distA2 = 30.5;
distA3 = 36.5;
distB1 = 22;

module guide(){
translate([0,-(distA2+5)/2,(tubeD+7)/2])
rotate([-90,0,0])
difference(){

union(){
tube(tubeD, tubeD+5, distA3+5);
translate([0,(tubeD+4)/2,(distA3+5)/2]) cube(size=[27,3,distA3+5],center=true);
}

translate([0,0,distA1]) rotate([0,90,0]) cylinder(r=m25Rad,h=40,$fn=30,center=true);
translate([0,0,distA2]) rotate([0,90,0]) cylinder(r=m25Rad,h=40,$fn=30,center=true);
translate([0,0,distA3]) rotate([0,90,0]) cylinder(r=m25Rad,h=40,$fn=30,center=true);
translate([0,0,distB1]) rotate([90,0,0]) cylinder(r=m25Rad,h=40,$fn=30,center=true);
translate([0,0,10]) rotate([90,0,0]) cylinder(r=5.5,h=40,$fn=30,center=true);
translate([0,0,32]) rotate([90,0,0]) cylinder(r=3,h=40,$fn=30,center=true);

}//diff

for(i=[-1,1]) for(j=[-1,1]) translate([i*16,j*20,0]) helperDisk(20);
}//end module

for(i=[-1,1]) translate([i*27,0,0]) guide();
