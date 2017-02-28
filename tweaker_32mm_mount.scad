/**
 * tweaker fpv camera mount
 */
 
use <dronePlates.scad>;

hDist = 27;//27=tweaker
height = 35;
spacerR = 5.5/2;
angle = 20;
hubSqH=10;

tolerance=0.4;
shiftY = 7.35;
shiftZ = 2.5;

/**
 *
 */
module cameraHub(tolerance=0){
sqL = 18;

translate([0,0,hubSqH/2]) cube(size=[sqL+tolerance,sqL+tolerance,hubSqH+tolerance], center=true);
cylinder(r=7.5+(tolerance/2), h=16, $fn=20);
for(i=[-1,1]) translate([i*10.25,0,0]) cylinder(h=hubSqH,r=2.7+(tolerance/2),$fn=30);
translate([0,0,16/2])cube(size=[2.75+tolerance,sqL+3.75+tolerance,16], center=true);
}//end module

/**
 *
 */
module camera(lensH=25){
difference(){
union(){
translate([0,0,1.5/2]) cube(size=[32,32,1.5], center=true);
cameraHub();
cylinder(r=6,h=lensH,$fn=20);
}
for(i=[-1,1]) for(j=[-1,1]) translate([i*27/2,j*27/2,-0.5]) cylinder(r=1.5, h=3, $fn=20);
}
}//end module

/**
 *
 */
module housing(){
difference(){
cube(size=[32,30,hubSqH-2], center=true);
scale([1,1,1.1]) translate([0,0,-hubSqH/2]) cameraHub(tolerance=tolerance);
translate([0,10,0]) cube(size=[32+1,10+0.5,hubSqH], center=true);
}
}//end module

/**
 *
 */
module pillars(){
difference(){

for(i=[-1,1]){
translate([i*hDist/2,0,0])
hull(){
	tube(spacerR*2, spacerR*2+4, height);
	rotate([-angle,0,0]) roundedRect([spacerR*2, spacerR*2, height],3);
}
}//for


translate([0,0,-10/2]) cube(size=[50,50,10], center=true);

}//diff

}//end module

///color("green") camera();
///housing();
///pillars();


difference(){
union(){
pillars();

translate([0,shiftY,height/2+shiftZ])
rotate([90-angle,0,0]){ 
color("grey") scale([1,1,1.1]) housing();
}
}//union

translate([0,shiftY,height/2+shiftZ]){
rotate([90-angle,0,0]){
color("red") translate([0,0,-hubSqH/2]) cameraHub(tolerance=tolerance);
}
}

for(i=[-1,1]) translate([i*hDist/2,0,0]) cylinder(r=spacerR, h=height, $fn=30);

}//diff


//show camera

translate([0,shiftY,height/2+shiftZ])
rotate([90-angle,0,0]){
color("green") translate([0,0,-hubSqH/2-1]) camera();
}



