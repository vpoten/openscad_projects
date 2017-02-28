/**
 * top mount for mobius using zmr250 pattern
 */

use <dronePlates.scad>;

m3Rad = 3.4/2;
plateThick = 1.5;
frHolesD = 19;

difference(){
union(){
	roundedRect([30,38,plateThick],3);
	roundedRect([10,38,plateThick+1.5],3);
	translate([0,-frHolesD,0]) roundedRect([45,6,plateThick+1.5],3);
}

translate([0,1,0])
for ( i = [-1,1]) for ( j = [-1,1]){ //mobius bobbins holes
	translate([i*22/2,j*28/2,-0.5]){
		cylinder(r=5.6/2,h=plateThick+1,$fn=20);
		translate([0,0,plateThick+0.5]) cylinder(r=7,h=plateThick,$fn=20);
	}
}

//frame attach holes
for ( i = [-1,1]) translate([i*20,-frHolesD,-0.5]) cylinder(r=m3Rad,h=plateThick+2,$fn=20);

//voids
for ( i = [-1:1]) translate([0,i*13,-0.5]) roundedRect([3,8,plateThick+2],2);
for ( i = [-1,1]) translate([i*11,1.5,-0.5]) roundedRect([3,8,plateThick+2],2);

}//diff

for(i=[-1,1]){
translate([i*22,-(frHolesD+6),0]) helperDisk(19);
translate([i*21,22,0]) helperDisk(19);
}
