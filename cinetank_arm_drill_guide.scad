/**
 * cinetank motor mount arm drill guide
 */
 
 use <dronePlates.scad>
 
 tubeD = 16.3;
 
 difference(){
    roundedRect([tubeD+6,tubeD+6,23],3);
     
    cylinder(r=tubeD/2,h=40,$fn=40);
     
    translate([0,0,15]) rotate([90,0,0]) cylinder(r=6.2/2,h=40,$fn=30,center=true);
 }