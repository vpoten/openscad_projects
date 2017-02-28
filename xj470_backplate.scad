/**
 * xj470 back plate for receiver and GPS
 */

use <dronePlates.scad>

m3Rad = 3.5/2;
plateThick = 3.5;

/**
 *
 */
module gpsPlate() {
difference(){
union(){
	crossSquarePlate(43);
	cylinder(h = plateThick, r = 11, $fn=30);
	for(i=[-1,1]){
	translate([i*25/2,-25,0]) cylinder(h=plateThick,r=5,$fn=30);
	translate([i*45/2,30,0]) cylinder(h=plateThick,r=5,$fn=30);
	}

	for(i=[-1,1]) translate([i*45/2,25,0])
	hull(){
	cylinder(h=plateThick,r=5,$fn=30);
	translate([0,5,0]) cylinder(h=plateThick,r=5,$fn=30);
	}

	for(i=[-1,1]) for(j=[-1,1]) translate([i*27,j*28,0]) helperDisk(22);
	
}//union

	cylinder(h = plateThick+5, r =m3Rad*2 , $fn=30, center=true);
	cube(size = [15,2,plateThick+5], center = true);
	cube(size = [2,15,plateThick+5], center = true);

	for(i=[-1,1]){
	translate([i*21,21,0]) cylinder(h=plateThick+5,r=m3Rad,$fn=30,center=true);

	translate([i*25/2,-25,0]){
	cylinder(h=plateThick+5,r=m3Rad,$fn=30,center=true);
	translate([0,0,plateThick-1.75]) cylinder(h=1.76,r=m3Rad*2,$fn=30);
	}
	translate([i*45/2,30,0]){
	cylinder(h=plateThick+5,r=m3Rad,$fn=30,center=true);
	translate([0,0,plateThick-1.75]) cylinder(h=1.76,r=m3Rad*2,$fn=30);
	}
	}
	
}//diff
}

/**
 *
 */
module receivPlate() {
difference(){
union(){
	roundedRect([30,45,plateThick], 4);
	translate([0,28,0]) roundedRect([50,20,plateThick], 4);

	for(i=[-1,1]){ 
		translate([i*26,42,0]) helperDisk(22);
		translate([i*18,-25,0]) helperDisk(22);
	}
	
}//union

	for(i=[-1,1]){
	translate([i*15/2,0,0]){
		cylinder(h=plateThick+5,r=m3Rad,$fn=30,center=true);
		translate([0,0,plateThick-1.75]) cylinder(h=1.76,r=m3Rad*2,$fn=30);
	}
	
	translate([i*30/2,25,0]) cylinder(h=plateThick+5,r=m3Rad*2,$fn=30,center=true);

	translate([0,i*13,-0.5]) roundedRect([15,7,plateThick+1], 3);

	translate([i*25/2,-20,0]) cylinder(h=plateThick+5,r=m3Rad,$fn=30,center=true);
	translate([i*45/2,35,0]){
		cylinder(h=plateThick+5,r=m3Rad,$fn=30,center=true);
		cylinder(h=2,r=m3Rad*2,$fn=30);
	}
	}
	
	translate([0,32,-0.5]) roundedRect([15,7,plateThick+1], 3);

	
}//diff
}


translate([-35,0,0]) gpsPlate();
translate([35,-5,0]) receivPlate();



