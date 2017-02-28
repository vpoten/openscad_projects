/**
 *
 */ 
use <dronePlates.scad>

m3Rad = 3.3/2;
thick = 1.5;
d1 = sqrt(2*30*30);
d2 = sqrt(2*30.5*30.5);

difference(){
    roundedRect([34,34,thick],3.5);
    
    rotate([0,0,45]) motorCircleMountHoles(0, 36, thick=thick, d1=d1, d2=d2, holeR=m3Rad);
    
    cylinder(r=2.5, h=thick*3, $fn=20, center=true);
}