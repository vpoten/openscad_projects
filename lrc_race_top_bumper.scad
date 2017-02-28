/**
 * lrc race X top bumper
 */
 
use <dronePlates.scad>;
use <BezierScad/BezierScad.scad>;

thick = 2.5;
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
                heightCtls = [thick-0.5, 7, thick-0.5],
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

front();

for(i=[-1,1]){
    for(j=[-1,1]){
        translate([i*holeXDst/2, j*holeYDst/2, -0.5])
        cylinder(r=m3Rad, h=10, $fn=30);
    }
}
