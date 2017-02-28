/**
 *
 */
 
use <dronePlates.scad>;

m3Rad = 3.4/2;
plateThick = 3;

difference(){

translate([0,-4,0])
union(){
	roundedRect([30,50,plateThick],3);
}


for ( i = [-1,1]) for ( j = [-1,1]){ //mobius bobbins holes
	translate([i*22/2,j*28/2,-0.5]){
		cylinder(r=5.6/2,h=plateThick+1,$fn=20);
		translate([0,0,plateThick/2+0.5]) cylinder(r=6,h=plateThick,$fn=20);
	}
}

//voids
for ( i = [-1,1]) translate([i*12,0,-0.5]) roundedRect([1,8,plateThick+2],1.2);

}//diff

