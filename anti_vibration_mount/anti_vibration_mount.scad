/**
 * anti vibration mount for APM 45x45 
 */

use <../dronePlates.scad>;

absorbDist = 38;
plateThick = 1.5;
mntDist = 45;
m3Rad = 3.5/2;
l1 = sqrt(2*mntDist*mntDist);

module corner(){
import("vibration_mount-one-foot.stl", convexity=4); 
}

module cornerSmall(){
import("vibration_mount-one-foot-small.stp", convexity=4); 
}

module dampener(){
translate([0,1.25,-0.5]) rotate([0,0,135]) import("M3_9mm_x_13mm_Dampener.stl", convexity=4);
}

/**
 *
 */
module bottom(){
difference(){

union(){
for(i=[0:3]) rotate([0,0,45+90*i]) translate([0,-absorbDist,-3]) corner();
roundedRect([(absorbDist-5)*2,(absorbDist-5)*2,plateThick],6);
}//union

for(i=[0:3]) rotate([0,0,90*i]) translate([0,l1/2,-0.5]) cylinder(r=m3Rad,h=plateThick+1,$fn=20);
translate([0,0,-0.5]) cylinder(r=absorbDist-11,h=plateThick+1,$fn=30);

translate([0,0,-2.5-2.5]) cylinder(r=absorbDist+11,h=5,$fn=30);
for(i=[0:3]) rotate([0,0,45+90*i]) translate([0,absorbDist+2.5,-0.005]) cylinder(r=4.5,h=plateThick+1,$fn=30);
}//diff
}//end bottom

/**
 *
 */
module top(){
topDist = absorbDist-3;
difference(){

union(){
for(i=[0:3]) rotate([0,0,45+90*i]) translate([0,-topDist,2]) rotate([0,180,180]) translate([0,0,-2.5]) corner();
hull(){
for(i=[0:3]) rotate([0,0,45+90*i]) translate([0,-topDist-8,0]) cylinder(r=4,h=plateThick,$fn=30);
}
}//union

difference(){
	translate([0,0,-0.5])  cylinder(r=topDist+13,h=plateThick+2,$fn=30);
	translate([0,0,-0.5]) cylinder(r=topDist+5,h=plateThick+2,$fn=30);
}//diff

for(i=[0:3]) rotate([0,0,45+90*i]) translate([0,-topDist+3,-0.005]) cylinder(r=5,h=plateThick+1,$fn=30);
translate([0,0,-0.5])  roundedRect([25,20,plateThick+1],3);
for(i=[-1,1]) translate([0,22*i,-0.5])  roundedRect([20,8,plateThick+1],3);
translate([-50,-50,plateThick]) cube(size=[100,100,5]);

for(i=[-1,1]) translate([24*i,0,plateThick-0.6])  roundedRect([12,28,plateThick],2);

}//diff
}// end top

bottom();
translate([0,0,13]) top();
color("blue") for(i=[0:3]) rotate([0,0,45+90*i]) translate([0,-absorbDist,0]) dampener();
