/**
 * lt210 fpv camera mount
 */
 
use <dronePlates.scad>;

thick = 1.5;
hubSqH=10;
tolerance=0.4;

/***
difference(){
    union(){
    import("qav210_fpvcam.stl", convexity=4);
    translate([0,7,5]) cube(size=[19,4,9], center=true);
    }
    
    translate([0,-13.5,8.5]) cube(size=[16.75,2,10], center=true);
    translate([0,5,0]) cube(size=[2.5,2.5,20], center=true);
}
***/

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


difference(){
    union(){
        translate([0,0,thick/2]) cube(size=[39,30,thick], center=true);
        for(i=[-1,1]) translate([i*20.5,0,thick/2]) cube(size=[2,8,thick], center=true);
        translate([4,0,hubSqH/2]) rotate([0,0,-90]) housing();
    }
    
    translate([3.5,0,0]) cylinder(r=8.2, h=20, center=true, $fn=30);
    translate([-5.75,0,0]) cube(size=[3,4,20], center=true);
    
}


