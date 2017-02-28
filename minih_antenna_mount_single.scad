/**
 * mini H parametrized antenna mount
 */
 
use <dronePlates.scad>;


m3Rad = 3.25/2;
thick = 2.5;
angle2 = 85;
holeAntDist = 8;

difference(){
    union(){
        roundedRect([6,holeAntDist+10,thick],3);
        
        //antenna holder
        difference(){
        translate([0,holeAntDist/2,-1]) rotate([-angle2/2,0,0]) tube(m3Rad*2, 8, 19);
        

        translate([0,0,-10/2]) cube(size=[100,100,10], center=true);
        translate([0,holeAntDist/2,10/2+8]) cube(size=[20,40,10], center=true);
        }//diff
    }
    
    for(i=[-1,1]){
        translate([0,-holeAntDist/2,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
    }
    
    
    translate([0,holeAntDist/2,-1]) rotate([-angle2/2,0,0]) cylinder(r=m3Rad, h=90, $fn=20,center=true);
    
}

