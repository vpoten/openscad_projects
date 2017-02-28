/**
 * mini H parametrized antenna mount
 */
 
use <dronePlates.scad>;

holeDist = 26;
m3Rad = 3.2/2;
thick = 2.5;
angle2 = 85;
antDist = 39;
holeAntShift = 5;

difference(){
    union(){
        hull(){
            for(i=[-1,1]) translate([0,i*holeDist/2,0]) roundedRect([7,6,thick],3);
            translate([holeAntShift,0,0]) roundedRect([5,antDist+10,thick],3);
        }
        
        //translate([-8/2+holeAntShift,-(antDist+7)/2,0]) cube(size=[8,antDist+7,thick+2.5]);
        
        //antenna holder
        difference(){

        for(i=[-1,1]){
        translate([holeAntShift,i*antDist/2,-1]) rotate([-i*angle2/2,0,0]) tube(m3Rad*2, 8, 19);
        }

        translate([holeAntShift,0,-10/2]) cube(size=[100,100,10], center=true);
        for(i=[-1,1]){
        translate([holeAntShift,i*antDist/2,10/2+8]) cube(size=[20,40,10], center=true);
        }

        }//diff
    }
    
    for(i=[-1,1]){
        translate([0,i*holeDist/2,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
    }
    
    for(i=[-1,1]){
    translate([holeAntShift,i*antDist/2,-1]) rotate([-i*angle2/2,0,0]) cylinder(r=m3Rad, h=90, $fn=20,center=true);
    }
}

