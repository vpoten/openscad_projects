/**
 * TBS disco XL motor mount clamp v2
 *
 */

use <dronePlates.scad>


m3Rad = 3.4/2;
plateThick = 5;
armWidth = 12.8;
mountDia = 45;
holesDist = 27;
holesR = 14;
isolator = 2.5;

clampL = armWidth+isolator*2+m3Rad*4+12;
clampH2 = armWidth*0.35+isolator*0.6;
clampH = plateThick+3+clampH2;
clampHAux = clampH2+4;

/**
 *
 */
module clamp(height, h2, counter=0 ){
difference(){
	roundedRect([clampL,armWidth-4,height], 4);
	translate([0,0,height-h2/2]){ cube(size=[armWidth+isolator*2,armWidth+1,h2+0.1],center=true); }
	//holes	
	translate([armWidth/2+isolator+5,0,height/2]){ cylinder(h=height+1, r=m3Rad, $fn=30, center=true); }
	translate([-(armWidth/2+isolator+5),0,height/2]){ cylinder(h=height+1, r=m3Rad, $fn=30, center=true); }

	if(counter>0){
		translate([armWidth/2+isolator+5,0,counter/2]){ cylinder(h = counter+0.1, r=4, $fn=30, center=true); }
		translate([-(armWidth/2+isolator+5),0,counter/2]){ cylinder(h = counter+0.1, r=4, $fn=30, center=true); }
	}
}//diff
}//end module clamp


translate([0,10,0]){ clamp(clampHAux, clampH2); }
translate([0,-10,0]){ clamp(clampHAux, clampH2); }
translate([0,30,0]){ clamp(clampHAux, clampH2); }
translate([0,-30,0]){ clamp(clampHAux, clampH2); }
