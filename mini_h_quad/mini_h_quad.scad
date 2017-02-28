/**
 * Mini H Quad for FPV
 *
 * @author: Victor Potenciano
 */

use <../dronePlates.scad>

// ########
// Rendering options

RENDER_COMPLETE_MODEL = false;
RENDER_ARM = false;
RENDER_CENTRAL_PLATE = false;
RENDER_BOTTOM_PLATE = false;
RENDER_TOP_PLATE = true;
RENDER_CAM_PLATE = false;
RENDER_SPACERS = false;

// ########

tau = 1.6180339;
m2Rad = 2.8/2;
m3Rad = 3.4/2;
armThick = 5;
plateThick = 3;
distShafts = 160; // distance between prop. shafts (same side)
distShaftFrame = 80; // distance shaft to frame central plate
frameL = 165;
frameW = 65;
frameH = 37;
armProj = (distShafts/2)-(distShafts/2*1/tau);
armL = sqrt(armProj*armProj+distShaftFrame*distShaftFrame);
armDist = distShafts-armProj*2;
armFastB = 12;
armFastH = 7;
armAngle = acos(distShaftFrame/armL);
propSize = 25.4*6;
camDist = 14;

echo("Arm proj.=", armProj, " and Arm length=", armL);
echo("Arm dist.=", armDist, " and Arm angle=", armAngle);


/**
 *
 */
module fasteningHoles(thick = armThick, rad = m3Rad){
	translate([-armL,-armFastB/2,0]){cylinder(h = thick, r = rad, $fn=30); }
	translate([-armL,armFastB/2,0]){cylinder(h = thick, r = rad, $fn=30); }
	translate([-armL-armFastH,0,0]){cylinder(h = thick, r = rad, $fn=30); }
}//end module

/**
 *
 */
module allFasteningHoles(thick = armThick, rad = m3Rad){
	for ( i = [-1,1] ) {
		translate([(frameW/2+distShaftFrame),i*distShafts/2,0]){//arms fastening holes
		rotate([0,0,i*armAngle]){fasteningHoles(thick = thick, rad=rad);} 
		}
		translate([-(frameW/2+distShaftFrame),i*distShafts/2,0]){//arms fastening holes
		rotate([0,0,180-i*armAngle]){fasteningHoles(thick = thick, rad=rad);}
		}
	}
}//end module

/**
 *
 */
module arm(){
	armD = 32;
	armW = armD*(1/tau);
	holesAng = 45;
	armShift = -(armL+20)/2;
	armHdist = 13;

difference(){
	union(){
	difference(){//motor mount
	rotate([0,0,holesAng]){ motorCircleMount(7, armD, thick=armThick, d1=16, d2=12, holeR=m2Rad ); }
	rotate([0,0,holesAng]){ motorCircleMountHoles(7, armD, thick=armThick, d1=16, d2=19, holeR=m2Rad ); }
	for ( i = [0 : 2] ) {
		rotate([0,0,i*120]){ translate([13,0,0]){ cylinder(h = armThick, r = m2Rad, $fn=30); } }
	}
	for ( i = [-1,1] ) {
		translate([0,i*10,0]){ cylinder(h = armThick, r = 3.5, $fn=30); }
	}
	}//diff
	
	difference(){//arm body
	translate([armShift,0,0]){ roundedRect([armL,armW,armThick], 2); }
	rotate([0,0,holesAng]){ motorCircleMountHoles(5, armD, thick=armThick, d1=16, d2=12, holeR=m2Rad); }
	translate([armShift,0,0]){	
		for(i = [-armL/2+armHdist : armHdist : (armL/2-15)]){
			for( j = [-1,1] ){
			translate([-i,j*armW/4,0]){ roundedRect([armHdist-5,armW/4-0.5,armThick], 2); }
			}
		}
	}

	//arm fastening	holes
	fasteningHoles();
	}//diff

	//landing support (REMOVED)
	///translate([-armD/2,armThick/2,0]){ rotate([90,0,0]){ roundedTriangle([10,12+armThick,armThick-0.75], 2);} }

	}//union

	//support hole
	translate([-(armD/2-1),0,armThick/2]){ cylinder(h = armThick+2, r = m3Rad, $fn=30, center=true); }
}//diff
}//end module arm

/**
 *
 */
module arrow(){
union(){
rotate([0,0,-135]){
	roundedTriangle([12,12,2], 1);
	translate([8,8,1]){ rotate([0,0,45]){cube([6,6,2], center=true);} }
}
}
}//end module

/**
 *
 */
module cameraPlateHoles(){
	hW=4.5;
	sep = 35;
	for(i=[-1,1])translate([i*sep/2,0,0]){ cube([hW,plateThick,plateThick],center=true);}
}//end module


/**
 *
 */
module centralPlate(top=false){
	cornerR = 4;
	topX =  frameW/2-cornerR;
	topY = frameL/2-cornerR;
	holeW = frameW/3;
	holeL = holeW*1/tau;

	difference(){
	union(){
	for ( i = [-1,1] ) {
	hull(){
		translate([(frameW/2+distShaftFrame),i*distShafts/2,0]){//arms fastening holes
		rotate([0,0,i*armAngle]){fasteningHoles(thick = plateThick, rad = cornerR+2);} 
		}
		translate([-(frameW/2+distShaftFrame),i*distShafts/2,0]){//arms fastening holes
		rotate([0,0,180-i*armAngle]){fasteningHoles(thick = plateThick, rad = cornerR+2);}
		}
		// top/botton vertices
		translate([topX-cornerR,i*topY,0]){cylinder(h = plateThick, r = cornerR, $fn=30);}
		translate([-(topX-cornerR),i*topY,0]){cylinder(h = plateThick, r = cornerR, $fn=30);}

		// inner vertices
		translate([topX-cornerR,i*(distShafts/2-50),0]){cylinder(h = plateThick, r = cornerR, $fn=30);}
		translate([-(topX-cornerR),i*(distShafts/2-50),0]){cylinder(h = plateThick, r = cornerR, $fn=30);}
	}//hull
	}//for

	translate([0,0,plateThick/2]){cube([frameW,distShafts/2,plateThick], center=true);}
	}//union
	
	//fastening holes
	allFasteningHoles(thick = plateThick+1);

	//flight controller holes
	for ( i = [-1,1]) { 
		for (j = [-1,1]) { translate([i*45/2,j*45/2,0]){ cylinder(h=plateThick+1, r=m3Rad, $fn=30);} } 
	}

	// plate holes
	for ( i = [-2:2]) { 
		translate([0,holeL*2*i,0]){ roundedRect([holeW,holeL,plateThick+1], 3);}
	}

	for ( i = [-2]) {
		for ( j = [-1,1]) { translate([j*(holeW-4),holeL*2*i,0]){ roundedRect([1,holeL+12,plateThick+1], 1);} }
	}

	for ( i = [-1:1]) {
		for ( j = [-1,1]) { translate([j*(holeW+6),holeL*2*i,0]){ roundedRect([1,holeL+5,plateThick+1], 1);} }
	}

	for ( i = [-1,1]) {//gopro spacer holes
		translate([i*17,(frameL/2-24),0]){ cylinder(h=plateThick+1, r=m3Rad, $fn=30);}
	}

	for ( i = [-1,1]) {
	for ( j = [-1,1]) {//outer spacer holes
		translate([i*25,j*(frameL/2-(camDist-7)),0]){ cylinder(h=plateThick+1, r=m3Rad, $fn=30);}
	}
	}

	//camera holes
	translate([0,frameL/2-camDist,plateThick/2]){cameraPlateHoles();}

	//ornamental arrows
	if(top==false){
		translate([0,(frameL/2-4),plateThick/2]){ arrow(); }
		///translate([0,-(frameL/2-18),plateThick/2]){ arrow(); }
	}

	if(top==true){
		for ( i = [-3:3]) { translate([0,holeL*2*i,0]){ roundedRect([holeW,holeL,plateThick+1], 3);} }
		for ( i = [-1:1]) { translate([0,holeL*2*i,0]){ roundedRect([holeW+6,holeL,plateThick+1], 3);} }
		for ( j = [-1,1]) { translate([j*(holeW+3.5),holeL*4,0]){ roundedRect([1,holeL+5,plateThick+1], 1);} }		
	}

	}//diff

}// end module

/**
 *
 */
module spacers(height=7){
	for(i=[-1,1]){
	for(j=[-2:2]){
		translate([i*7,j*12,0]){
		difference(){
			cylinder(h=height, r=4, $fn=30);
			cylinder(h=height, r=m3Rad, $fn=30);
		}
		}
	}
	}
}//end module

/**
 *
 */
module bottomPlate(){
	cornerR = 4;
	topX =  frameW/2-cornerR;
	topY = frameL/2-cornerR;
	holeW = frameW/3;
	holeL = holeW*1/tau;

	difference(){
	union(){
	for ( i = [-1,1] ) {
	hull(){
		translate([(frameW/2+distShaftFrame),i*distShafts/2,0]){//arms fastening holes
		rotate([0,0,i*armAngle]){fasteningHoles(thick = plateThick, rad = cornerR+2);} 
		}
		translate([-(frameW/2+distShaftFrame),i*distShafts/2,0]){//arms fastening holes
		rotate([0,0,180-i*armAngle]){fasteningHoles(thick = plateThick, rad = cornerR+2);}
		}

		// inner vertices
		translate([topX-cornerR,i*(distShafts/2-50),0]){cylinder(h = plateThick, r = cornerR, $fn=30);}
		translate([-(topX-cornerR),i*(distShafts/2-50),0]){cylinder(h = plateThick, r = cornerR, $fn=30);}
	}//hull
	}//for

	translate([0,0,plateThick/2]){cube([frameW-10,distShafts/2,plateThick], center=true);}
	}//union
	
	//fastening holes
	allFasteningHoles(thick = plateThick+1);

	//flight controller holes
	for ( i = [-1,1]) { 
		for (j = [-1,1]) { translate([i*45/2,j*45/2,0]){ cylinder(h=plateThick+1, r=m3Rad, $fn=30);} } 
	}

	// plate holes
	for ( i = [-1:1]) { 
		translate([0,holeL*2*i,0]){ roundedRect([holeW,holeL,plateThick+1], 3);}
	}

	for ( i = [-1,1]) { translate([i*holeW,0,0]){ roundedRect([2,holeL+10,plateThick+1],1);} }

	for ( i = [-1,1]) { 
		translate([0,i*armDist/2,0]){ roundedRect([holeW+14,holeL-2,plateThick+1], 3);}
	}

	}//diff
}// end module

/**
 *
 */
module cameraPlate(){
holeRad = 10.5;
camHoleD = 27.5;

union(){
	difference(){
		cube([45,frameH,plateThick],center=true);
		
		//main hole
		cylinder(h = 5, r=holeRad, $fn=30, center=true);
		// cam holes
		for(i = [-1,1]){
			for(j = [-1,1]){ translate([i*camHoleD/2,j*camHoleD/2,0]){ cylinder(h = 5, r=m3Rad, $fn=30, center=true);} }
		}
	}//diff

	for(i = [-1,1]){ translate([0,i*(frameH/2+plateThick/2),0]){rotate([90,0,0]){ cameraPlateHoles(); }} }
}
}// end module

// ###########
//Render section

if( RENDER_COMPLETE_MODEL==true ){
for ( i = [-1,1] ) {
	//position 4 arms and propellers
	translate([(frameW/2+distShaftFrame),i*distShafts/2,]){
	translate([0,0,20]){ color("black") propeller(propSize); }
	rotate([180,0,i*armAngle]){arm();} 
	}
	translate([-(frameW/2+distShaftFrame),i*distShafts/2,]){
	translate([0,0,20]){ color("black") propeller(propSize); }
	rotate([180,0,180-i*armAngle]){arm();}
	}
}

translate([0,0,frameH+plateThick]){ color("steelblue",0.7) centralPlate(top=true); }
translate([0,0,0]){ color("red",0.7) centralPlate(); }
translate([0,0,-plateThick-armThick]){ color("lime") bottomPlate(); }
translate([0,frameL/2-camDist,frameH/2+plateThick]){ rotate([90,0,0]){ color("silver") cameraPlate();} }
}// end if

if( RENDER_ARM==true ){
	union(){
	arm();
	for(i = [-1,1]){ translate([-armL-13,i*10,0]){ helperDisk(18); }  }
	translate([18,0,0]){ helperDisk(21); }
	}
}// end if

if( RENDER_CENTRAL_PLATE==true ){
	color("red") centralPlate();
}// end if

if( RENDER_BOTTOM_PLATE==true ){
	color("lime") bottomPlate();
}// end if

if( RENDER_TOP_PLATE==true ){
	color("steelblue") centralPlate(top=true);
}// end if

if( RENDER_CAM_PLATE==true ){
	color("silver") cameraPlate();
}// end if

if( RENDER_SPACERS==true ){
	spacers();
}// end if
