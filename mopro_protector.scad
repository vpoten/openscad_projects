/**
 * MoPro protector
 *
 */

use <dronePlates.scad>

camW = 59;
camH = 41;
thick = 4;

lensCx = 12.5;
lensCy = 13.5;
lensRad = 17.5/2;


//color("lightblue"){
//translate([0,0,-1]) cube([camW,camH,2], center=true);
//}

difference(){
    union(){
        roundedRect([camW-1,camH-1,thick], 2.5);
        translate([camW/2-lensCx,camH/2-1,0]) roundedRect([lensRad*2,2.1,thick+3], 1);
        for(i=[-1,1] ){
            translate([0,i*(camH/2+2),0]) roundedRect([33, 5, thick], 3);
        }
    }
    
    //lens hole
    translate([camW/2-lensCx,camH/2-lensCy,-0.5]) cylinder(r=lensRad, h=thick+1, $fn=40);
    
    //buttons hole
    translate([camW/2-20,camH/2-30,-0.5]) roundedRect([25,6,thick+1],2.5);
    
    //heatsink
    for(i=[-1,1]){
    translate([(camW/2-40)+i*4,camH/2-18,-0.5]) roundedRect([3,11,thick+1],2);
    }
    
    //led hole
    translate([camW/2-21,camH/2-10,-0.5]) cylinder(r=1.3, h=thick+1, $fn=40);
    
    //velcro strap holes
    for(i=[-1,1]){
    translate([0,i*(camH/2+1.3),-0.5]) roundedRect([17,1.2,thick+1],1);
    }
}