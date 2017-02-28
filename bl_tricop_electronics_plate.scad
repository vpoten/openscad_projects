/**
 * bl tricopter electronics plate
 *
 */

use <dronePlates.scad>

w = 73;
h = 79;
squareL = 45;
hplateW = 25;
m3Rad = 3.1/2;
plateThick = 3;

union(){
	crossSquarePlate(45);
	translate([w/2+hplateW/2,0,0]){ hShapePlate(h, hplateW); }
	translate([-w/2-hplateW/2,0,0]){ hShapePlate(h, hplateW); }
	translate([0,-h/2-hplateW/2,0]){ rotate([0,0,90]){hShapePlate(w, hplateW);} }

	//tubes	
	translate([squareL/2, squareL/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	translate([squareL/2, -squareL/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	translate([-squareL/2, squareL/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	translate([-squareL/2, -squareL/2, 0]) {tube(m3Rad*2, 6.5, plateThick+2);}
	
	//connectors
	translate([squareL/2+10, squareL/2-6, plateThick/2]) {cube(size = [15,8,plateThick], center=true);}
	translate([squareL/2+10, -(squareL/2-6), plateThick/2]) {cube(size = [15,8,plateThick], center=true);}
	translate([-(squareL/2+10), squareL/2-6, plateThick/2]) {cube(size = [15,8,plateThick], center=true);}
	translate([-(squareL/2+10), -(squareL/2-6), plateThick/2]) {cube(size = [15,8,plateThick], center=true);}
	rotate([0,0,-90]){
		translate([squareL/2+10, squareL/2-6, plateThick/2]) {cube(size = [15,8,plateThick], center=true);}
		translate([squareL/2+10, -(squareL/2-6), plateThick/2]) {cube(size = [15,8,plateThick], center=true);}
	}
}
