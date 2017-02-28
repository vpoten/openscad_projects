/**
 * Mini X Quad for FPV, ZMR250 pattern
 *
 * @author: Victor Potenciano
 */

use <../dronePlates.scad>
use <../BezierScad/BezierScad.scad>;

// ########
// Rendering options

RENDER_COMPLETE_MODEL = false;
RENDER_CENTRAL_PLATE = false;
RENDER_BOTTOM_PLATE = true;
RENDER_TOP_PLATE = false;
RENDER_ARM = false;
RENDER_SET_ARM = false;

// ########
// parameters

m3Rad = 3.3/2;
thick = 2;
armThick = 3;
standoffR = 21.567;
propSize = 5.5*25.4;
armW = 31;
armL = 95;//74=krieger


//distances for arm holes location
d1 = sqrt(2*30.5*30.5)/2;// dist: center -> hole
d2 = sqrt(armL*armL+6*6);// dist: hole -> motor
angM = asin(6/d2);


echo("d:center->hole=", d1, " d:hole->motor=", d2);
echo("ang:motor-hole-pivot=", angM);
echo("diameter=", (d1+d2)*2);

// ############
// Modules

/**
 *
 */
module fasteningHolesZMR(thick = armThick, rad=m3Rad){
    //zmr250 pattern
	for(i=[0,1]){
		translate([0,i*-12,0]) cylinder(h = thick, r = rad, $fn=30);
		translate([9.8,i*-12,0]) cylinder(h = thick, r = rad, $fn=30);
	}
}

module holePatternZMRtoX1stAnd2ndQuad(thick = armThick, rad=m3Rad){
    translate([30.5/2,30.5/2,0]) rotate([0,0,45+angM]) fasteningHolesZMR(thick, rad);
    translate([-30.5/2,30.5/2,0]) rotate([0,0,-45-angM]) mirror([1,0,0]) fasteningHolesZMR(thick, rad);
}

module armToX1stAnd2ndQuad(){
    translate([30.5/2,30.5/2,0]) rotate([0,0,45+angM]) arm();
    translate([-30.5/2,30.5/2,0]) rotate([0,0,-45-angM]) mirror([1,0,0]) arm();
}

/**
 *
 */
module holePatternZMRtoX(thick = armThick, rad=m3Rad) {
    holePatternZMRtoX1stAnd2ndQuad(thick, rad);
    mirror([0,1,0]) holePatternZMRtoX1stAnd2ndQuad(thick, rad);
}

/**
 *
 */
module arm(){
    difference(){
    translate([0,-6,0])
    difference(){
        union(){
        translate([-5.5,-armW/2,0]) cube([armL,armW,armThick]);
        translate([armL,0,0]){
            hull(){
                roundedRect([22,armW-4,armThick], 4);
                for(i=[-1,1]) translate([i*17,0,0]) cylinder(r=5, h=armThick, $fn=20);
            }
            translate([0,0,20]) propeller(propSize);
            ///translate([0,0,5]) propeller(28.5);
        }
        }
        
        
        translate([armL,0,-0.5]) rotate([0,0,45]) motorCircleMountHoles(8, 29, thick=armThick+1, holeR=m3Rad);
        translate([armL,0,-0.5]) motorCircleMountHoles(8, 29, thick=armThick+1, , holeR=2.3/2, d1=16, d2=8);
    }
    fasteningHolesZMR();
    }
}

/**
 *
 */
module pdbHoles(thick, rad){
    
    for(i=[-1,1]){
        for(j=[-1,1]) translate([i*30.5/2,j*30.5/2,0]) cylinder(r=rad, h=thick, $fn=20);
    }
}


module basePlate(top=true) {
    lThick = (top==true) ? thick : thick+armThick;
    
    difference(){
    union(){
        curvature(lThick);
        mirror([1,0,0]) curvature(lThick);
        
        mirror([0,1,0]){
            curvature(lThick);
            mirror([1,0,0]) curvature(lThick);
        }
        
        if( top==true ){
            pdbHoles(thick+2.25, 3.5);
        }
    }
    
    
    holePatternZMRtoX();
        
    
    pdbHoles(thick+3, m3Rad);
        
    translate([0,0,-0.5]) cylinder(r=7, h=thick+armThick+1, $fn=30);
    
    
    //carve arms in bottom plate
    if( top==false ){
        
        for(i=[-1,1]){ 
            translate([i*30,0,thick+armThick/2]) cube(size=[15,10,armThick], center=true);
        }
        
        translate([0,0,thick]){
            armToX1stAnd2ndQuad();
            mirror([0,1,0]) armToX1stAnd2ndQuad();
        }
        holePatternZMRtoX(thick = armThick+thick);
    }
    
    }//diff
}

/**
 *
 */
module topPlate() {
    // TODO
}

/**
 *
 */
module curvature(h = thick){
BezArc([
  [33, 0],
  [33, 10],
  [50, 15],
  [25, 28],
  [22, 38],
  [10, 23],
  [0, 23],
  ],
    focalPoint=[0,0],
    height=h,
    steps = 20,
    showCtlR = 0
);
    
    //color("pink")
    //holePatternZMRtoX1stAnd2ndQuad();
    
}//end module


// ##############################
// ##############################


if( RENDER_COMPLETE_MODEL==true ){
color("coral") translate([0,0,-thick-armThick]) basePlate(top=false);

basePlate(top=true);

//arms
color("lime") translate([0,0,-armThick]){
armToX1stAnd2ndQuad();
mirror([0,1,0]) armToX1stAnd2ndQuad();
}

//standoffs
aux2 = sqrt((standoffR*standoffR)/2); 
color("red")
for(i=[-1,1]) for(j=[-1,1]){
    translate([i*aux2,j*aux2,thick]) cylinder(r=2.6, h=35, $fn=20);
    translate([i*30.5/2,j*30.5/2,thick]) cylinder(r=2.6, h=8, $fn=20);
}

color("lightgrey") translate([0,0,thick+35]) topPlate();

translate([0,0,-thick-armThick-3]) tube(2*(d1+d2)-2,2*(d1+d2)+2,3);
}



//curvature();

if(RENDER_CENTRAL_PLATE==true) {
    basePlate(top=true);  
}


if(RENDER_BOTTOM_PLATE==true) {
    basePlate(top=false);  
}


if(RENDER_TOP_PLATE==true) {
    topPlate();
}

if(RENDER_ARM==true) {
    arm();
}

if(RENDER_SET_ARM==true) {
    armToX1stAnd2ndQuad();
    mirror([0,1,0]) armToX1stAnd2ndQuad();
}

        
    
