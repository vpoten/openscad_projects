/**
 * TBS disco XL motor mount
 *
 */

use <dronePlates.scad>


m3Rad = 3.4/2;
plateThick = 4;
armWidth = 12.8;
armSupp = 42;
armTubeT = 4;
armTubeW = armWidth+armTubeT*2;
fixHoleD = 30;
mountDia = 50;
trside = sqrt(0.5*mountDia*mountDia);
holesDist = 17;
holesR = 4.5;

difference(){

union(){

//motor mount
rotate([0,0,-45]){ motorCircleMount(8, mountDia, plateThick ); }

//reinforcement
translate([0,-mountDia,0]){
scale([1.01, 1.75, 1]){ rotate([0,0,45]){ roundedTriangle([trside,trside,plateThick], 4); } }
}

//square tube 
translate([0,-14,(armTubeW/2)+plateThick-armTubeT]){ 
	rotate([90,0,0]){ 
		difference(){
		squareTube(armWidth, armTubeW, armSupp);
		translate([0,0,fixHoleD]){ rotate([0,90,0]){cylinder(h = armTubeW+1, r = m3Rad, $fn=30, center=true);} }
		translate([0,0,fixHoleD-20]){ rotate([0,90,0]){cylinder(h = armTubeW+1, r = m3Rad, $fn=30, center=true);} }
		}
	} 
}

}//end union

rotate([0,0,-45]){ motorCircleMountHoles(8, mountDia, plateThick); }

//mount plate holes
translate([-holesDist,0,plateThick/2]){ cylinder(h = plateThick+1, r = holesR, $fn=30, center=true); }
translate([holesDist,0,plateThick/2]){ cylinder(h = plateThick+1, r = holesR, $fn=30, center=true); }
translate([0,holesDist,plateThick/2]){ cylinder(h = plateThick+1, r = holesR, $fn=30, center=true); }
translate([0,-holesDist,plateThick/2]){ cylinder(h = plateThick+1, r = holesR, $fn=30, center=true); }
translate([0,-(3*holesDist-7),plateThick/2]){ cylinder(h = armWidth*4, r = holesR, $fn=30, center=true); }

}//end diff
