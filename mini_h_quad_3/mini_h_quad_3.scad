/**
 * Mini H Quad for FPV v3
 *
 * @author: Victor Potenciano
 */

use <../dronePlates.scad>;

// ########
// Rendering options

RENDER_COMPLETE_MODEL = true;
RENDER_ARM = false;
RENDER_CENTRAL_PLATE = false;
RENDER_BOTTOM_PLATE = false;
RENDER_TOP_PLATE = false;
RENDER_CAM_PLATE = false;

HELPER_DISKS = false;
ZMR250 = true;
ZMR250SPACERS =true;

// ########

tau = 1.6180339;
m2Rad = 2.6/2;
m3Rad = 3.4/2;
armThick = 4;
armThickBase = 7;
plateThick = 2;
propSize = 25.4*6;
distShafts = 180; // distance between prop. shafts (same side)
frameL = 160;
frameW = 80;
frameH = 35;
camDist = 14;
armL = propSize/2+10;
armFastB = 8;
armAngle1 = 80;
armAngle2 = 120;
fpvCamAng = 0;

armProj1 = sin(90-armAngle1)*armL;
armProj2 = sin(armAngle2-90)*armL;
armDist = distShafts-armProj1-armProj2;


echo("Arm proj1.=", armProj1, " and Arm proj2.=", armProj2);
echo("Arm dist.=", armDist, " and Arm length=", armL);
echo("Arm angle1=", armAngle1, " and Arm angle2=", armAngle2);


/**
 *
 */
module defaultFasteningHoles(thick = armThickBase, rad = m3Rad, complete=true ){
	
	if(complete==true) { translate([-armL,0,0]) cylinder(h = thick, r = rad, $fn=30);  }
	translate([-armL-armFastB,0,0]) cylinder(h = thick, r = rad, $fn=30);
}//end module

/**
 *
 */
module zmr250Holes(thick = armThickBase, rad = m3Rad, complete=true ){
	//zmr250 pattern
	if(complete==true)
	translate([-armL-4.5,0,0])
	for(i=[-1,1]){
		translate([-5,i*6,0]) cylinder(h = thick, r = rad, $fn=30);
		translate([5,i*6,0]) cylinder(h = thick, r = rad, $fn=30);
	}
}//end module

/**
 *
 */
module allFasteningHoles(thick = armThick, rad = m3Rad, complete=true){
for(i=[-1,1]){
translate([-i*frameW/2,armDist/2,0]) 
rotate([0,0,90+i*armAngle1]) translate([armL,0,0]){
if(ZMR250==false)
defaultFasteningHoles(thick = thick, rad=rad, complete=complete);
else
zmr250Holes(thick = thick, rad=rad, complete=complete);
}

translate([-i*frameW/2,-armDist/2,0]) 
rotate([0,0,90+i*armAngle2]) translate([armL,0,0]){
if(ZMR250==false)
defaultFasteningHoles(thick = thick, rad=rad, complete=complete);
else
zmr250Holes(thick = thick, rad=rad, complete=complete);
}
}
}//end module

/**
 *
 */
module zmr250Spacer(thick = 15){
	difference(){
	roundedRect([16,19,thick],3);

	//zmr250 pattern
	for(i=[-1,1]){
		translate([-5,i*6,-0.5]) cylinder(h = thick+1, r = m3Rad, $fn=30);
		translate([5,i*6,-0.5]) cylinder(h = thick+1, r = m3Rad, $fn=30);
	}

	translate([0,0,6]) rotate([0,90,0]) cylinder(r=3, h=40, center=true, $fn=20);
	translate([0,0,16]) cube(size=[20,6,20], center=true);

	}//diff

	
}//end module

/**
 *
 */
module allZmr250Spacers(thick = 15){
for(i=[-1,1]){
translate([-i*frameW/2,armDist/2,0]) 
rotate([0,0,90+i*armAngle1]) translate([-4,0,0]){
zmr250Spacer(thick = thick);
}

translate([-i*frameW/2,-armDist/2,0]) 
rotate([0,0,90+i*armAngle2]) translate([-4,0,0]){
zmr250Spacer(thick = thick);
}
}
}//end module

/**
 *
 */
module arm(){
	armD = 28;
	holesAng = 45;
	bodyAng = 2.5;
difference(){
	union(){
	//motor mount
	translate([0,0,0.5])
	hull(){
		rotate([0,0,holesAng]) motorCircleMountHoles(7, armD, thick=armThick-1, d1=armD, d2=16, holeR=m3Rad+2 );
		motorCircleMountHoles(7, armD, thick=armThick-1, d1=armD, d2=20, holeR=m3Rad+2 );
	}
	
	//arm body
	hull(){
		for(i=[-1,1]){
			translate([-armL-4,i*9.5,armThickBase/2]) rotate([i*-bodyAng,0,0]) cube(size=[18,2,armThickBase], center=true);
		}
	}

	//arm body
	translate([-armL/2-12,0,armThick+1]) rotate([0,90,0])
	hull(){
		cylinder(h=armL,r=2, $fn=20, center=true);
		for(i=[-1,1]){
			translate([armThick-1,i*9,0]) rotate([i*-bodyAng,0,0]) cube(size=[armThick,armThick,armL], center=true);
		}
	}
	}//union

	// arm fastening holes
	translate([0,0,-0.5]) defaultFasteningHoles(thick=armThickBase+2);

	// motor mount holes
	rotate([0,0,holesAng]){ motorCircleMountHoles(6, armD, thick=armThick, d1=19, d2=12, holeR=m2Rad ); }
	rotate([0,0,0]){ motorCircleMountHoles(6, armD, thick=armThick, d1=19, d2=16, holeR=m3Rad ); }

	hull(){
		for(i=[0:7]) rotate([0,0,i*45]) translate([armD/2,0,armThick]) cylinder(h=armThick,r=3, $fn=20);
	}

	// body rounded holes
	translate([-armD+5,0,armThick]) roundedRect([17,3,armThick],3);
	translate([-armL/2+9,0,-1]) roundedRect([17,3,20],3);
	translate([-armL/2-19,0,-1]) roundedRect([17,3,20],3);

	for(i=[-1,1]) translate([-armL-14,i*12,armThickBase/2]) rotate([0,0,i*45]) cube(size=[10,10,armThickBase+2], center=true);


}//diff
}//end module arm

/**
 *
 */
module variableCross(l1, l2, thick=plateThick){
	l1 = sqrt(2*l1*l1);
	l2 = sqrt(2*l2*l2);
	rotate([0,0,45]) motorCircleMountHoles(m3Rad*2, l1+1, thick=thick, d1=l1, d2=l2, holeR=m3Rad);
}//end module

/**
 *
 */
module arrow(thick=plateThick){
union(){
rotate([0,0,-135]){
	roundedTriangle([12,12,thick], 1);
	translate([8,8,thick/2]){ rotate([0,0,45]){cube([6,6,thick], center=true);} }
}
}
}//end module


/**
 *
 */
module elasticHook(){
rotate([0,0,180])
difference(){
	roundedRect([16,9,plateThick+1], 3);
	roundedRect([10,4,plateThick+1], 1.2);
	translate([-2.5,-6,0]) cube(size=[5,5,plateThick+1]);
}
}

/**
 *
 */
module sideArcs(_thick=plateThick){
	arcShiftY1 = cos(armAngle1)*50;
	arcShiftY2 = abs(cos(armAngle2))*50;
	arcShiftX1 = sin(armAngle1)*50;
	arcShiftX2 = sin(armAngle2)*50;

	for(j=[-1,1])
	translate([j*(frameW/2),0,0]){
		hull(){
			translate([0,(armDist/2-15),-0.5]) cylinder(r=4,h=_thick+1,$fn=20);
			translate([0,-(armDist/2-17.5),-0.5]) cylinder(r=4,h=_thick+1,$fn=20);
			translate([j*arcShiftX1,(armDist/2-15+arcShiftY1),-0.5]) cylinder(r=4,h=_thick+1,$fn=20);
			translate([j*arcShiftX2,-(armDist/2-17.5+arcShiftY2),-0.5]) cylinder(r=4,h=_thick+1,$fn=20);
		}
	}
}//

/**
 *
 */
module mobiusMountHoles() {
for ( i = [-1,1]) for ( j = [-1,1]){ //mobius bobbins holes
	translate([i*22/2,j*28/2,-0.5]) cylinder(r=5.6/2,h=plateThick+1,$fn=20);
}
}//

/**
 *
 */
module centralPlate(top=false){
cornerR = 3;
shift1 = (top==true) ? 8 : 0;
shift2 = (top==true) ? 8 : 0;

difference(){
	union(){
		hull(){
		for(i=[-1,1]){
		translate([-i*(frameW/2-shift1),armDist/2,0]) 
		rotate([0,0,90+i*armAngle1]) roundedRect([8,18,plateThick], 3);

		translate([-i*(frameW/2-shift2),-armDist/2,0]) 
		rotate([0,0,90+i*armAngle2]) roundedRect([8,18,plateThick], 3);
		}
		}//hull
		
		if( top==false ){ 
		//cameras place
		translate([0,armDist/2+22,0]) roundedRect([frameW+4,35,plateThick], 3);
		}
		else{
		difference(){
		translate([0,armDist/2+16,0]) roundedRect([frameW+4,46,plateThick], 3);
		translate([0,armDist/2+30,-0.5]) roundedRect([frameW-22,28,plateThick+1], 3);
		}//diff
		}

		//rear
		hull(){
			for(i=[-1,1]){
			translate([i*28,-armDist/2,0]) cylinder(r=8,h=plateThick,$fn=30);
			translate([i*22,-armDist/2-15,0]) cylinder(r=8,h=plateThick,$fn=30);
			}
		}

	}//union

	allFasteningHoles(complete=(!top));
	
	//front holes
	for(i = [-1,1]) translate([i*37,armDist/2+33,-0.5]) cylinder(r=m3Rad,h=plateThick+1,$fn=20);

	if( top==true ){
	for(i = [-1,1]){
		translate([i*20,armDist/2+8,-0.5]) roundedRect([11,2,plateThick+1], 1.4); 
	}
	}
	else{
	for(i = [-1,1]){
		translate([i*25,armDist/2+26,-0.5]) roundedRect([2,14,plateThick+1], 1.4);
	}	
	}

	if(top==false){
	translate([0,armDist/2+30,-0.5]){ roundedRect([16,2,plateThick+1], 1.2);}//fpv cam
	}
	else{
	translate([0,armDist/2+8,-0.5]) roundedRect([11,2,plateThick+1], 1.4);
	}

	if( ZMR250==true ){
		// central spacers holes
		for ( i = [-1:1]) { for ( j = [-1,1])
		translate([j*(frameW/2-9),i*30,-0.5]){ cylinder(r=m3Rad,h=plateThick+1,$fn=20);}
		}
	}

	if(top==false){//flight controller holes
	translate([0,0,0]) {
	variableCross(45.5, 30);
	translate([0,0,-0.5]) cylinder(r=8,h=plateThick+1,$fn=20);

	for ( i = [-1,1]) { for ( j = [-1,1]) //holes for battery and servo cable
		translate([j*15,i*35,-0.5]){ roundedRect([12,6,plateThick+1], 3);}
		translate([i*25,0,-0.5]) roundedRect([2,19,plateThick+1], 2);
	}
	}//translate
	}
	
	//side arcs
	sideArcs();
	
	//rear holes
	translate([0,-armDist/2-17,-0.5]) cylinder(r=m3Rad*2,h=plateThick+1,$fn=20);
	for(j = [-1:1]){
		translate([j*23,-armDist/2-17,-0.5]) cylinder(r=m3Rad,h=plateThick+1,$fn=20);
		translate([j*16,-armDist/2-17,-0.5]){ cylinder(r=m3Rad,h=plateThick+1,$fn=20);}
	}
	
	
	if(top==false){
		translate([0,-armDist/2,-0.5]) roundedRect([12,8,plateThick+1], 3);
		for ( j = [-1,1]){ //rear holes
		translate([j*23,-armDist/2+3,-0.5]){ roundedRect([2,20,plateThick+1], 1.2);}
		}
	}
	else{
		for(i=[-3:1]) translate([0,(-armDist/2+25)-i*20,-0.5]) roundedRect([24,6,plateThick+1], 3.2);
		for(i=[-1:1]) for ( j = [-1,1]){ //rear holes
		translate([j*23,-armDist/2-i*40+50,-0.5]){ roundedRect([2,28,plateThick+1], 1.2);}
		}

		if( ZMR250==true ){
		for(j = [-1,1]){//antenna holes
		translate([j*(frameW/2-8),-armDist/2+7,-0.5]) cylinder(r=m3Rad*2,h=plateThick+1,$fn=20);
		translate([j*(frameW/2-5),armDist/2,-0.5]) cylinder(r=m3Rad*2,h=plateThick+1,$fn=20);
	}	
		}
	}

	//elastic band hook
	if( top==false ){	
	translate([1,(armDist/2)+3,-0.5]){ 
		elasticHook();
		mobiusMountHoles();
	}
	}
	else{
	translate([1,(armDist/2)-6,-0.5]) elasticHook();
	}
}//diff
}//end module centralPlate

/**
 *
 */
module bottomPlate(xtra=0.25){
	cornerR = 3;
	

	difference(){
	union(){
		hull(){
		for(i=[-1,1]){
		translate([-i*frameW/2,armDist/2,0]) 
		rotate([0,0,90+i*armAngle1]) roundedRect([8,18,plateThick+xtra], 3);

		translate([-i*frameW/2,-armDist/2,0]) 
		rotate([0,0,90+i*armAngle2]) roundedRect([8,18,plateThick+xtra], 3);
		}
		}//hull
		//rear
		/*
		hull(){
			for(i=[-1,1]){
			translate([i*25,-armDist/2,0]) cylinder(r=8,h=plateThick,$fn=30);
			translate([i*22,-armDist/2-35,0]) cylinder(r=8,h=plateThick,$fn=30);
			}
		}*/
		if(ZMR250==true && ZMR250SPACERS==true){
			allZmr250Spacers(thick = 15+plateThick+xtra);
		}
	}//union
	
	//fastening holes
	allFasteningHoles(thick = plateThick+xtra+1);

	translate([0,0,0]) {//flight controller holes
	variableCross(45.5, 30, thick=plateThick+xtra);
	for ( i = [-1,1]) translate([0,i*sqrt(2*45*45)/2,0]) cylinder(r=m3Rad,h=plateThick+xtra+1,$fn=20);
	translate([0,0,-0.5]) cylinder(r=10,h=plateThick+xtra+1,$fn=20);


	for ( i = [-1,1]) { for ( j = [-1,1]) { //ESC holes
		translate([j*20,i*43,-0.5]) roundedRect([7,20,plateThick+xtra+1], 2);
		translate([0,i*46,-0.5]) roundedRect([5,25,plateThick+xtra+1], 2);
		translate([i*23,0,-0.5]) roundedRect([3,18,plateThick+xtra+1], 2);
		translate([0,i*23,-0.5]) roundedRect([16,4,plateThick+xtra+1], 2);
	}}
	}//translate

	if( ZMR250==true ){
		// central spacers holes
		for ( i = [-1:1]) { for ( j = [-1,1])
		translate([j*(frameW/2-9),i*30,-0.5]){ cylinder(r=m3Rad,h=plateThick+1,$fn=20);}
		}
	}

	//side arcs
	sideArcs(plateThick+xtra);

	}//diff
}// end module


/**
 *
 */
module cameraPlate(){
lensRad = 13.5/2;
camH = 26;

translate([0,0,camH/4+2])
difference(){
	cube(size=[lensRad*2+14,6,camH/2+4], center=true);
	translate([0,0,camH/4+2]) rotate([90-fpvCamAng,0,0]) cylinder(h=11,r=lensRad,$fn=20,center=true);

	//torus
	translate([0,0,10]) rotate([90,0,0])
	rotate_extrude(convexity = 10)
	translate([lensRad+4, 0, 0]) scale([0.7,1,1]) circle(r = 2, $fn = 100);

	for(i=[-1,1]) translate([6*i,0,-4]){ 
	cube(size=[m3Rad*4,12,m3Rad*2], center=true);
	translate([0,0,-3])cylinder(h=8,r=m3Rad,$fn=20,center=true);
	}
}//diff

}// end module


/**
 *
 */
module battery() {
	cube([104,36,25], center=true);//2200 3s
}// end module

/**
 *
 */
module fpvCamera() {
	cube([32,10,32], center=true);
	translate([0,10,0]) rotate([90,0,0]) cylinder(h=15, r=6.25, $fn=15, center=true);
}// end module

/**
 *
 */
module flightCtrl(size = 33) {
	cube([size,size,15], center=true);
}// end module

/**
 *
 */
module vtx() {
	antennaH = 70;
	cube([60,25,10], center=true);
	translate([28,0,antennaH/2]) cylinder(h=antennaH, r=1, $fn=10, center=true);
	translate([28,0,antennaH]) cylinder(h=10, r1=15, r2=10,$fn=10, center=true);
}// end module

/**
 *
 */
module rx() {
	cube([50,35,13], center=true);
	translate([30,0,0]) rotate([0,90,0]) cylinder(h=15, r=0.75, $fn=5, center=true);
}// end module

/**
 *
 */
module esc12A() {
	cube([40,20,5], center=true);
}// end module

/**
 *
 */
module pdb() {
	cube([50,50,5], center=true);
}// end module

/**
 *
 */
module goPro() {
	cube([59,21,41], center=true);
	translate([-15,15,8]) rotate([90,0,0]) cylinder(h=10, r=11, $fn=20, center=true);
}// end module

// ###########
//Render section

if( RENDER_COMPLETE_MODEL==true ){
for(i=[-1,1]){
//position 4 arms and propellers
translate([-i*frameW/2,armDist/2,-armThickBase])
rotate([0,0,90+i*armAngle1]) translate([armL,0,0]){
translate([0,0,20]){ color("black") propeller(propSize); }
arm();
}

translate([-i*frameW/2,-armDist/2,-armThickBase]) 
rotate([0,0,90+i*armAngle2]) translate([armL,0,0]){
translate([0,0,20]){ color("black") propeller(propSize); }
arm();
}
}//for

color("silver", 0.8) translate([0,armDist/2+28,23]) goPro();
color("Yellow", 0.8) translate([0,40,11]) rotate([0,0,0]) rx();
color("Orchid", 0.8) translate([0,0,-15]) flightCtrl();
color("Yellow", 0.8) translate([0,0,-5]) pdb();
color("lime", 0.8) translate([-10,armDist/2-21,frameH-plateThick]) rotate([0,0,180]) vtx();
for(i=[-1,1]) for(j=[-1,1]) translate([i*12,j*50,-5]) rotate([0,0,90]) esc12A();
color("SkyBlue", 0.8) translate([0,-armDist/2+30,15]) rotate([0,0,90]) battery();

translate([0,0,frameH+plateThick]){ color("steelblue",0.7) centralPlate(top=true); }
translate([0,0,0]){ color("red",0.7) centralPlate(); }
translate([0,0,-plateThick-armThickBase-0.5-15]){ color("lime") bottomPlate(); }
color("Yellow", 0.8) translate([0,armDist/2+20,-17]) rotate([-fpvCamAng,0,0]) fpvCamera();
translate([24,armDist/2+6,37])  color("silver") cameraPlate();
}// end if

if( RENDER_ARM==true ){
	union(){
	arm();
	if( HELPER_DISKS==true ){
		for(i = [-1,1]){ 
		translate([-armL-17,i*12,0]) helperDisk(25); 
		translate([0,i*24,0]) helperDisk(25);
		}
		translate([24,0,0]) helperDisk(25);
	}
	}
}// end if

if( RENDER_CENTRAL_PLATE==true ){
	color("red") centralPlate();
	if( HELPER_DISKS==true ){
		for(i = [-1,1]) translate([i*(frameW/2+6),armDist/2+29,0]) helperDisk(28);
		for(i = [-1,1]) translate([i*(frameW/2+10),-armDist/2+9,0]) helperDisk(28);
		for(j=[-1,1]) translate([j*(frameW/2-20),-armDist/2-46,0]) helperDisk(28);
	}
}// end if

if( RENDER_BOTTOM_PLATE==true ){
	color("lime") bottomPlate();
}// end if

if( RENDER_TOP_PLATE==true ){
	color("steelblue") centralPlate(top=true);
	if( HELPER_DISKS==true ){
		for(i = [-1,1]) for(j=[-1,1]) translate([i*(frameW/2+2),j*(armDist/2+9),0]) helperDisk(28);
		for(j=[-1,1]) translate([j*(frameW/2-20),-armDist/2-48,0]) helperDisk(28);
	}
}// end if

if( RENDER_CAM_PLATE==true ){
	color("silver") cameraPlate();
}// end if

