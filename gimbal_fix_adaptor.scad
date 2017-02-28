/**
 * adaptor for gopro attachment
 */

use <dronePlates.scad>

m3Rad = 3.5/2;
plateThick = 3.75;

difference(){
union(){

translate([-2,3,0]) cube(size=[4,9,20+plateThick]);
roundedRect([12,40,plateThick],3);
for(i=[0,1]) translate([0,i*15,0]) cylinder(h=20+plateThick,r1=6,r2=4,$fn=30);


}//union

for(i=[0,1]) translate([0,i*15,-0.5]) cylinder(h=30,r=m3Rad,$fn=30);
translate([0,-(22-15/2),-0.5]) cylinder(h=plateThick+1,r=7.5/2,$fn=30);

}//diff
