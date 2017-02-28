/**
 * tbs discovery gopro mount 
 */
 
use <dronePlates.scad>

module notch(){
    thick=2.75;
    translate([0,0,-thick/2])
    difference(){
        union(){
        roundedRect([8,2,thick],2);
        translate([-3.5,-5,0])cube(size=[7,5,thick]);
        }
        
        for(i=[-1,1]) translate([4.5*i,-4.5,0]) cylinder(r=3,h=6,$fn=30,center=true);
    }
}

difference(){
    cube(size=[40+13,37,10.5], center=true);
    
    for(i=[-1,1]){ 
        translate([i*40/2,0,-0.5]) rotate([90,0,0]) cylinder(r=6.4/2,h=38,center=true,$fn=20);
        translate([0,i*(37/2+5),0]) cylinder(r=15,h=15,center=true,$fn=40);
    }
        
    translate([0,0,40]) rotate([90,0,0]) cylinder(r=40,h=38,center=true,$fn=40);
    
}

for(i=[-1,1]) for(j=[-1,1]){
        translate([i*50/2,j*20/2,9]) rotate([90,0,90]) notch();
    }

