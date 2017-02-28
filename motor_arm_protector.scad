/**
 * motor/arm protector
 *
 * @author: Victor Potenciano
 */

use <dronePlates.scad>

m3Rad = 3.3/2;
thick = 1.5;
armThick = 4;
motorD = 30;


difference(){
    hull(){
        cylinder(r=motorD/2, h=armThick+thick, $fn=30);
        
        for(i=[-1,1])
        translate([motorD/2+2,i*5,0]) cylinder(r=5, h=armThick+thick, $fn=40);
    }
    
    translate([0,0,thick])
    cylinder(r=motorD/2+0.5, h=armThick+0.1, $fn=50);
    
    translate([-motorD/2-8,-20,-0.5])
    cube(size=[10,40,10]);
    
    translate([0,0,-0.5]){
    rotate([0,0,45]) motorCircleMountHoles(0, motorD, thick=armThick+1, holeR=m3Rad);
    motorCircleMountHoles(0, motorD, thick=armThick+1, , holeR=2.3/2, d1=16, d2=12);
    }
}//diff