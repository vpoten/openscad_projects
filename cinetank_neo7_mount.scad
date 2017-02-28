/**
 * cinetank mk2 plate for neo7 GPS
 */

use <dronePlates.scad>

m3Rad = 3.6/2;
plateThick = 2.25;
holeDist=53.5;

/**
 *
 */
module gpsPlate() {
difference(){
union(){
	crossSquarePlate(43, thick=plateThick);
	cylinder(h = plateThick, r = 11, $fn=30);
	roundedRect([holeDist+6,6,plateThick], 3);
//	for(i=[-1,1]) for(j=[-1,1]) translate([i*27,j*28,0]) helperDisk(22);
	
}//union

	cylinder(h = plateThick+5, r =m3Rad*2 , $fn=30, center=true);
	cube(size = [15,2,plateThick+5], center = true);
	cube(size = [2,15,plateThick+5], center = true);

	for(i=[-1,1]) translate([i*holeDist/2,0,-0.5]) cylinder(h = plateThick+1, r = m3Rad, $fn=30);
}//diff
}



translate([0,0,0]) gpsPlate();
