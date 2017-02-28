/**
 *
 */

use <dronePlates.scad>

m3Rad = 3.1/2;
plateThick = 2.5;
shift=28;

/**
 *
 */
module hexagon(rad, cornerR, thick) {
hull(){
	for(i=[0:5]){
	rotate([0,0,60*i]) translate([rad,0,0]) cylinder(r=cornerR, h=thick, $fn=20);
	}
}
}//end module hexagon


difference(){
    union(){
    roundedRect([shift+4,shift+4,plateThick],3);
    for(i=[-1,1]) for(j=[-1,1]){
    translate([i*shift/2,j*shift/2,0]) cylinder(r=m3Rad*2, h=plateThick+4, $fn=20);
    }
    
    translate([shift/2+7,-20/2,0]) cube(size=[3,20,12]);
    translate([shift/2+4,-3/2,0]) cube(size=[4,3,12]);
    translate([shift/2,-20/2,0]) cube(size=[8,20,plateThick]);
    }
    
    scale([1,1.1,1]) hexagon(8, 3, plateThick+1);
    
    for(i=[-1,1]) for(j=[-1,1]){
    translate([i*shift/2,j*shift/2,-0.5]) cylinder(r=m3Rad, h=plateThick+6, $fn=20);
    }
    
    for(i=[-1,1]) translate([shift/2+5,i*6,6]) rotate([0,90,0]) cylinder(r=m3Rad, h=plateThick+6, $fn=20);
}

