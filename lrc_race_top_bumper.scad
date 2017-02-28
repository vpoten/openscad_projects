/**
 * lrc race X top bumper
 */
 
use <dronePlates.scad>;
use <BezierScad/BezierScad.scad>;

thick = 2.25;
thickB = 1.5;
holeXDst = 46.5;
holeYDst = 25;
m3Rad = 3.4/2;

module front() {
    difference(){
        union(){
            BezWall([
              [0,holeYDst/2],
              [9,10],
              [9,-10],
              [0,-holeYDst/2],
              ],  
                widthCtls = [m3Rad*4, m3Rad*1.25, m3Rad*4],
                heightCtls = [thick-0.95, 11, thick-0.95],
                steps = 20,
                centered = true
            );
           
           for(j=[-1,1]){
                translate([0, j*holeYDst/2, 0])
                cylinder(r=m3Rad*2, h=thick, $fn=30);
           } 
        }
        
        for(j=[-1,1]){
            translate([0, j*holeYDst/2, -0.5]){
            cylinder(r=m3Rad, h=thick+1, $fn=30);
            translate([0,0,thick+0.5]){
                cylinder(r=m3Rad*2, h=thick+1, $fn=30);
            }
            }
        } 
    }
}

module back() {
    difference(){
        hull(){
            for(j=[-1,1]){
                translate([0, j*holeYDst/2, 0])
                cylinder(r=m3Rad*2, h=thickB, $fn=30);
            }
            
            translate([3.5, 0, 0]){
                cylinder(r=11/2 , h=thickB, $fn=30);
            }
        }
       
       for(j=[-1,1]){
           translate([0, j*holeYDst/2, -0.5]){
           cylinder(r=m3Rad, h=thickB+1, $fn=30);
           }
       }
       
       translate([3.5, 0, -0.5]){
           cylinder(r=7/2 , h=thickB+1, $fn=30);
       }
    }
}

translate([12, 0, 0]) front();
back();

/*
for(i=[-1,1]){
    for(j=[-1,1]){
        translate([i*holeXDst/2, j*holeYDst/2, -0.5])
        cylinder(r=m3Rad, h=10, $fn=30);
    }
}
*/
