/**
 * cinetank gimbal mount
 */

use <dronePlates.scad>

m3Rad = 3.3/2;
holeDist=53.5;
height=30;
tubeRad=8/2;
protr=20;

difference(){
union(){
hull(){
for(i=[-1,1]) translate([i*holeDist/2,0,tubeRad]) rotate([90,0,0]) cylinder(r=tubeRad, h=height, $fn=20, center=true);
}//hull
cylinder(r=height/2,h=protr,$fn=20);
}

translate([0,0,0]){
rotate([0,0,45]) motorCircleMountHoles(7, height, thick=50, d1=19, d2=16, holeR=m3Rad );
}

for(i=[-1,1]) translate([i*holeDist/2,0,tubeRad]) rotate([90,0,0]) cylinder(r=m3Rad, h=height, $fn=20, center=true);
    
translate([0,0,0.5-5]){
rotate([0,0,45]) motorCircleMountHoles(7, height, thick=protr-1, d1=19, d2=16, holeR=m3Rad*2+0.5 );
}
 
for(i=[-1,1]) translate([i*(holeDist/2-7),0,0]) roundedRect([2.5,15,tubeRad*2],2);
}//diff


