/**
 * Mini X Quad for FPV, micro version
 *
 * @author: Victor Potenciano
 */

use <../dronePlates.scad>
use <../BezierScad/BezierScad.scad>;

// ########
// Rendering options

RENDER_COMPLETE_MODEL = false;
RENDER_CENTRAL_PLATE = false;
RENDER_BOTTOM_PLATE = false;
RENDER_TOP_PLATE = false;
RENDER_TOP_PLATE_2 = false;
RENDER_MIDDLE_ARC = true;

// ########
// parameters

m3Rad = 3.3/2;
thick = 2;
armThick = 4;
standoffR = 21.56;
propSize = 4*25.4;
armW = 20;
armL = 74;//74=krieger

angle2 = 85;
antDist = 35;
holeAntShift = -26 ;


// ############
// Modules

/**
 *
 */
module fasteningHolesKrieger(thick = armThick, rad=m3Rad){
    
    cylinder(r=rad, h=thick, $fn=20);
    for(i=[-1,1]){
        translate([7,i*11/2,0]) cylinder(r=rad, h=thick, $fn=20);
    }
}

/**
 *
 */
module arm(){
    difference(){
        union(){
        translate([-3.5,-armW/2,0]) cube([70,armW,armThick]);
        translate([armL,0,0]){
            hull(){
                roundedRect([22,24,armThick], 4);
                for(i=[-1,1]) translate([i*17,0,0]) cylinder(r=5, h=armThick, $fn=20);
            }
            translate([0,0,20]) propeller(propSize);
            ///translate([0,0,5]) propeller(28.5);
        }
        }
        
        fasteningHolesKrieger();
        translate([armL,0,-0.5]) rotate([0,0,45]) motorCircleMountHoles(8, 29, thick=armThick+1, holeR=m3Rad);
        translate([armL,0,-0.5]) motorCircleMountHoles(8, 29, thick=armThick+1, , holeR=2.3/2, d1=16, d2=8);
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
    difference(){
    union(){
        for(i=[0:3]){
            rotate([0,0,90*i]){ 
                if(top==true){ curvature(); }
                else{ curvature(h=thick+armThick); }
            }
        }
        
        if( top==true ){
            pdbHoles(thick+2.25, 3.5);
        }
    }
    
    
    for(i=[0:3]){
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) fasteningHolesKrieger(thick=thick+1);
        }
        
    if( top==true ){
            pdbHoles(thick+3, m3Rad);
    }
        
    translate([0,0,-0.5]) cylinder(r=9, h=thick+armThick+1, $fn=30);
    
    
    //carve arms in bottom plate
    if( top==false ){
        for(i=[0:3]){ 
            rotate([0,0,i*90+45]) translate([standoffR-20,0,armThick/2+thick]){
                hull(){
                    translate([50+armW+0.5-4.5,0,0]) cube([100,armW+0.5, armThick], center=true);
                    translate([armW+0.5,0,0]) cylinder(r=(armW+0.5)/2, h=armThick, center=true);
                }
            } 
        }
        
    }
    
    }//diff
}

/**
 *
 */
module topPlate() {
    l_thick = 3;
  
    difference(){
    union(){
        curvature2(h=l_thick);
        mirror([1,0,0]) curvature2(h=l_thick);
        
        mirror([0,1,0]){
        curvature3(h=l_thick);
        mirror([1,0,0]) curvature3(h=l_thick);
        }
    }
    
    for(i=[0:3]){
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    }
    
    translate([0,0,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    
    //fpv antenna hole
    translate([5,-(standoffR-2.5),-0.5]) cylinder(r=6.75/2, h=l_thick+1, $fn=20);
    
    
    }
}

/**
 *
 */
module topPlate2() {
    l_thick = 3;
  
    difference(){
    union(){
        curvature2(h=l_thick);
        mirror([1,0,0]) curvature2(h=l_thick);
        
        mirror([0,1,0]){
        curvature4(h=l_thick);
        mirror([1,0,0]) curvature4(h=l_thick);
        }
        
    }
    
    for(i=[0:3]){
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    }
    
    translate([0,0,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    translate([0,-35,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    
    //fpv antenna hole
    translate([6,-28,-0.5]) cylinder(r=6.75/2, h=l_thick+1, $fn=20);
    
    
    }
    
}

/**
 *
 */
module curvature(h = thick){
    aux1 = sqrt((standoffR+13)*(standoffR+13)/2); 
BezArc([
  [aux1, aux1],
  [aux1-15, aux1+17],
  [aux1-20, aux1-12],
  [-(aux1-20),aux1-12],
  [-(aux1-15),aux1+17],
  [-aux1,aux1]
  ],
    focalPoint=[0,0],
    height=h,
    steps = 30,
    showCtlR = 0
);
    /**
    color("pink")
    for(i=[0:1]){
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) fasteningHolesKrieger(thick=thick+1);
    }
    **/
        
}//end module

/**
 *
 */
module curvature2(h = thick) {
BezArc([
  [0, 7.5],
  [16, 7],
  [8, 23],
  [14, 22.5],
  [23, 22],
  [20, 8],
  [20, 0]
  ],
    focalPoint=[0,0],
    height=h,
    steps = 30,
    showCtlR = 0
);
    /*
    color("pink"){
            rotate([0,0,45]) translate([standoffR,0,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
       
       translate([0,12,(thick+1)/2-0.5]) cube([16,8,thick+1], center=true); 
    }
    */
        
}//end module

/**
 *
 */
module curvature3(h = thick){
BezArc([
  [0, 26],
  [24, 26],
  [20, 8],
  [20, 0]
  ],
    focalPoint=[0,0],
    height=h,
    steps = 30,
    showCtlR = 0
);
    /*
    color("pink"){
            rotate([0,0,45]) translate([standoffR,0,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
    }
    */  
}//end module


/**
 *
 */
module curvature4(h = thick) {
BezArc([
  [0, 40],
  [25, 40],
  [19, 8],
  [20, 0]
  ],
    focalPoint=[0,0],
    height=h,
    steps = 30,
    showCtlR = 0
);
    /*
    color("pink"){
            translate([30.5/2,30.5/2,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
        
        translate([0,30.5/2+22,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
    }
    */
        
}//end module

/**
 *
 */
module curvature5(h = thick) {
BezWall([
  [0, 20.25],
  [16, 20.25],
  [30.5/2, 10],
  [30.5/2, 0]
  ],
    widthCtls = [9, 7, 7], 
    height = h, 
    steps = 20,
    centered = true,
    showCtlR = 0
);
    /*
    color("pink"){
            translate([30.5/2,0,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
        
        translate([0,22,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
    }
    */
        
}//end module

/**
 *
 */
module middleArc(){
    l_thick = 4;
    
    difference(){
        union(){
            curvature5(h=l_thick);
            mirror([1,0,0]) curvature5(h=l_thick);
            for(i=[-1,1]){
                translate([i*30.5/2,0,0]) cylinder(r=7/2, h=7, $fn=20);
            }
        }
    
    
    
    translate([0,20,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    
    for(i=[-1,1]){
        translate([i*30.5/2,0,-0.5]) cylinder(r=m3Rad, h=l_thick+5, $fn=20);
    }
    
    
    }//diff
}//end module
    

// ##############################
// ##############################


if( RENDER_COMPLETE_MODEL==true ){
color("coral") translate([0,0,-thick-armThick]) basePlate(top=false);

basePlate(top=true);

//arms
color("lime")
for(i=[0:3]){
    rotate([0,0,90*i+45]) translate([standoffR,0,-armThick]) arm();
}

//standoffs
aux2 = sqrt((standoffR*standoffR)/2); 
color("red")
for(i=[-1,1]) for(j=[-1,1]){
    translate([i*aux2,j*aux2,thick+2]) cylinder(r=2.6, h=35, $fn=20);
}

color("lightgrey") translate([0,0,thick+35+2]) topPlate2();
translate([0,-30.5/2,12]) rotate([0,180,0]) rotate([0,0,180]) middleArc();
}

///curvature();
//curvature2();
///curvature3();
//curvature4();
//curvature5();

if(RENDER_CENTRAL_PLATE==true) {
    basePlate(top=true);  
}


if(RENDER_BOTTOM_PLATE==true) {
    basePlate(top=false);  
}


if(RENDER_TOP_PLATE==true) {
    topPlate();
}

if(RENDER_TOP_PLATE_2==true) {
    topPlate2();
}

if(RENDER_MIDDLE_ARC==true) {
    middleArc();
}




        
    
