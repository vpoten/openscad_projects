/**
 * lt210 fpv camera mount
 */
 
use <dronePlates.scad>;

thick = 1.5;
hubSqH=25;
tolerance=0.4;
front_cc = 28;
angle=45;

/**
 *
 */
module cameraHub(tolerance=0){
sqL = 18;

translate([0,0,hubSqH/2]) cube(size=[sqL+tolerance,sqL+tolerance,hubSqH+tolerance], center=true);
cylinder(r=7.5+(tolerance/2), h=16, $fn=20);
for(i=[-1,1]) translate([i*10.25,0,0]) cylinder(h=hubSqH,r=2.7+(tolerance/2),$fn=30);
translate([0,0,16/2])cube(size=[3+tolerance,sqL+4+tolerance,16], center=true);
}//end module

/**
 *
 */
module housing(){
difference(){
cube(size=[30,30,hubSqH-2], center=true);
scale([1,1,1.1]) translate([0,0,-hubSqH/2]) cameraHub(tolerance=tolerance);
translate([0,13,0]) cube(size=[32+1,10+0.5,hubSqH], center=true);
}
}//end module

/**
 *
 */
module fpvCam(){
    union(){
    cube([32,32,1.5], center=true);
    translate([0,0,4]) cube([18,18,8], center=true);
    cylinder(r=8.5, h=25, $fn=20);
    }
}

shiftZ= 7;
shiftX=8;
preShZ = 0;
color("grey") translate([-1,0,17]) rotate([0,180-angle,0]) fpvCam();

color(alpha=0.4)
difference(){
    union(){
        cube([35,37,9], center=true);
        translate([shiftX,0,shiftZ])  rotate([0,-angle,0]) translate([0,0,-preShZ]) rotate([0,0,-90]) housing();
    }
    
    translate([shiftX,0,shiftZ]) rotate([0,-angle,0]) {
    translate([0,0,preShZ]) rotate([0,0,-90]) cameraHub(tolerance=tolerance);
    cylinder(r=8.2, h=60, center=true, $fn=30);
    translate([-9.25,0,0]) cube(size=[4,4,60], center=true);
    }
    
    for(i=[-1,1]){
        translate([0,i*front_cc/2,0]) rotate([0,90,0]) 
            cylinder(r=5.3/2, h=100, $fn=30, center=true);
    }
    
    translate([10,0,0]) cube(size=[18,20,50], center=true);
    translate([35/2+10/2,0,0]) cube(size=[10,40,50], center=true);
    translate([0,0,-9.5]) cube(size=[40,40,10], center=true);
    translate([-18,0,0]) cube(size=[10,20,50], center=true);
}


