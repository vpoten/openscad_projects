/**
 * TBS discovery electronics plate
 * for neo7 gps
 */

use <dronePlates.scad>


m3Rad = 3.5/2;
plateThick = 3;
conTubeThick = 7;

difference(){
union(){
	
	translate([0, 60, 0]) {crossSquarePlate(45);}

	translate([0, -50, 0]) {
		crossSquarePlate(43);
		cylinder(h = plateThick, r = 11, $fn=30);
	}

	translate([0,8,0]){ hShapePlate(23, 50, thick=plateThick); }
	

	//tubes for crossplate 1
	//translate([45/2, 60-45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	//translate([-45/2, 60-45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	//translate([45/2, 60+45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	//translate([-45/2, 60+45/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}

	//tubes for crossplate 2
	//translate([32/2, -45-32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}
	//translate([-32/2, -45-32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}
	//translate([32/2, -45+32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}
	//translate([-32/2, -45+32/2, 0]) {tube(m3Rad*2, 6.5, plateThick+3);}

	// tubes
	for(i=[-1,1]){	
		translate([i*58/2, 98/2, 0]) {tube(m3Rad*2, 8, conTubeThick);}
		translate([i*45/2, -98/2, 0]) {tube(m3Rad*2, 8, conTubeThick);}
	}
	
	//connectors
	for(i=[-1,1]){
		translate([i*17, 27, plateThick/2]) {cube(size = [8,20,plateThick], center=true);}
		translate([i*13, -15, plateThick/2]) {cube(size = [8,20,plateThick], center=true);}
	}

	//connect mounting tubes to plates
	for(i=[-1,1]){
		translate([i*23.5, 98/2, conTubeThick/2]) {cube(size = [6.5,6.5,conTubeThick], center=true);}
		//translate([i*19, -98/2, conTubeThick/2]) {cube(size = [3.5,6.5,conTubeThick], center=true);}
	}

	//helper disks
	for(i=[-1,1]){
		translate([i*28,60+28,0]) { helperDisk(19); }
		translate([i*25,-120/2-18,0]) { helperDisk(19); }
	}
	
}//union

	translate([0, -50, 0]) {
		cylinder(h = plateThick+5, r =m3Rad*2 , $fn=30, center=true);
		cube(size = [15,1.5,plateThick+5], center = true);
		cube(size = [1.5,15,plateThick+5], center = true);
	}
	for(i=[-1,1]){
	translate([i*45/2, -98/2, 0]) {cylinder(h = plateThick+5, r =m3Rad , $fn=30, center=true);}
	}
}//diff

