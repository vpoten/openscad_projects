/**
 * TBS discovery electronics plate
 *
 */

use <dronePlates.scad>


m3Rad = 3.2/2;
plateThick = 3;
conTubeThick = 2;

union(){
	
	translate([0, 60, 0]) {crossSquarePlate(45);}
	translate([0, -45, 0]) {crossSquarePlate(32);}
	translate([0,0,0]){ hShapePlate(23, 50); }

	//tubes for crossplate 1
	translate([45/2, 60-45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	translate([-45/2, 60-45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	translate([45/2, 60+45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	translate([-45/2, 60+45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}

	//tubes for crossplate 2
	translate([32/2, -45-32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}
	translate([-32/2, -45-32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}
	translate([32/2, -45+32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}
	translate([-32/2, -45+32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}

	// tubes	
	translate([58/2, 98/2, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
	translate([-58/2, 98/2, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
	translate([45/2, -98/2, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
	translate([-45/2, -98/2, 0]) {tube(m3Rad*2, 6.5, conTubeThick-1);}
	
	//connectors
	translate([17, 23, plateThick/2]) {cube(size = [8,25,plateThick], center=true);}
	translate([-17, 23, plateThick/2]) {cube(size = [8,25,plateThick], center=true);}
	translate([13, -20, plateThick/2]) {cube(size = [8,15,plateThick], center=true);}	
	translate([-13, -20, plateThick/2]) {cube(size = [8,15,plateThick], center=true);}

	//connect mounting tubes to plates
	translate([25.5, 98/2, conTubeThick/2]) {cube(size = [3.5,6.5,conTubeThick], center=true);}
	translate([-25.5, 98/2, conTubeThick/2]) {cube(size = [3.5,6.5,conTubeThick], center=true);}
	translate([19, -98/2, conTubeThick/2]) {cube(size = [3.5,6.5,conTubeThick], center=true);}
	translate([-19, -98/2,(conTubeThick-1)/2]) {cube(size = [3.5,6.5,conTubeThick-1], center=true);}

	//helper disks
	translate([30,60+28,0]) { helperDisk(18); }
	translate([-30,60+28,0]) { helperDisk(18); }

	translate([22,-99/2-18,0]) { helperDisk(18); }
	translate([-22,-99/2-18,0]) { helperDisk(18); }
	
}
/*
//spacers
union(){
translate([28, -4, 0]) {cube(size = [10,32,0.6], center=false);}
translate([33, 0, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
translate([33, 8, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
translate([33, 16, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
translate([33, 24, 0]) {tube(m3Rad*2, 6.5, conTubeThick);}
}

union(){
translate([-38, -4, 0]) {cube(size = [10,32,0.6], center=false);}
translate([-33, 0, 0]) {tube(m3Rad*2, 6.5, 9);}
translate([-33, 8, 0]) {tube(m3Rad*2, 6.5, 9);}
translate([-33, 16, 0]) {tube(m3Rad*2, 6.5, 9);}
translate([-33, 24, 0]) {tube(m3Rad*2, 6.5, 9);}
}
*/
