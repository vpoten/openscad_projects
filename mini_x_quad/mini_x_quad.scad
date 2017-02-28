/**
 * Mini X Quad for FPV
 *
 * @author: Victor Potenciano
 */

use <../dronePlates.scad>
use <../BezierScad/BezierScad.scad>;

// ########
// Rendering options

RENDER_COMPLETE_MODEL = true;
RENDER_CENTRAL_PLATE = false;
RENDER_BOTTOM_PLATE = false;
RENDER_TOP_PLATE = false;

// ########
// parameters

m3Rad = 3.3/2;
thick = 2;
armThick = 4;
standoffR = 28;
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
    }
    
    if( top==true){
        translate([0,0,-0.5]) pdbHoles(thick=thick+1, rad=m3Rad);
    }
    else{
        translate([0,0,-0.5]) pdbHoles(thick=thick+1, rad=m3Rad*2);
    }
    
    for(i=[0:3]){
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) fasteningHolesKrieger(thick=thick+1);
        }
        
    if( top==true){
        translate([0,0,-0.5]) roundedRect([21,37.5,thick+1],3);
    }
    else{
        translate([0,0,-0.5]) roundedRect([15,15,thick+1],3);
    }
    
    //velcro strap holes
    if( top==false){
        for(i=[-1,1]) translate([0,i*38/2,-0.5]) slot(16, thick+1, 1);
    }
    
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
        
        translate([0,0,armThick/2+thick]) cube([25,40, armThick], center=true);
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
        for(i=[1,3]){
            rotate([0,0,-90*i]) curvature2(h=l_thick);
        }
        
        rotate([0,0,0]) curvature3(h=l_thick);
        rotate([0,0,180]) curvature4(h=l_thick);
        
        //antenna holder
        difference(){

            for(i=[-1,1]){
            translate([i*antDist/2,holeAntShift,0]) rotate([0,i*angle2/2,i*-30]) translate([0,0,-2]) tube(m3Rad*2, 8, 18);
            }

            translate([0,holeAntShift,-10/2]) cube(size=[100,100,10], center=true);
            for(i=[-1,1]){
            translate([i*antDist/2, holeAntShift,10/2+7]) cube(size=[40,20,10], center=true);
            }
        }//diff (antenna holder)
    }
    
    for(i=[0:3]){
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    }
    
    translate([0,0,-0.5]) cylinder(r=m3Rad, h=l_thick+1, $fn=20);
    
    //fpv antenna hole
    translate([5,-(standoffR-5),-0.5]) cylinder(r=6.75/2, h=l_thick+1, $fn=20);
    
    //holes
    for(i=[-1,1]) rotate([0,0,i*45]) {
        translate([0,-12,-0.5])
        hull(){
            cylinder(r=3, h=l_thick+1, $fn=20);
            translate([0,-5,0]) cylinder(r=3.5, h=l_thick+1, $fn=20);
        }
    }
    
    //antenna holder
    for(i=[-1,1]){
    translate([i*antDist/2,holeAntShift,0]) rotate([0,i*angle2/2,i*-30]) cylinder(r=m3Rad, h=90, $fn=20,center=true);
    }
    
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
module curvature2(h = thick){
    aux1 = sqrt((standoffR+4.5)*(standoffR+4.5)/2); 
BezArc([
  [aux1, aux1],
  [aux1-12, aux1+10],
  [aux1-20, aux1-10],
  [-(aux1-20),aux1-10],
  [-(aux1-12),aux1+10],
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
            rotate([0,0,90*i+45]) translate([standoffR,0,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
    }
    **/
    
        
}//end module

/**
 *
 */
module curvature3(h = thick){
    aux1 = sqrt((standoffR+4.5)*(standoffR+4.5)/2); 
BezArc([
  [aux1, aux1],
  [aux1-14, aux1+10],
  [aux1-16, aux1-30],
  [-(aux1-16),aux1-30],
  [-(aux1-14),aux1+10],
  [-aux1,aux1]
  ],
    focalPoint=[0,0],
    height=h,
    steps = 30,
    showCtlR = 0
);
        
}//end module

/**
 *
 */
module curvature4(h = thick){
    aux1 = sqrt((standoffR+4.5)*(standoffR+4.5)/2); 
BezArc([
  [aux1, aux1],
  [aux1-12, aux1+10],
  [aux1-16, aux1+7],
  [-(aux1-16),aux1+7],
  [-(aux1-12),aux1+10],
  [-aux1,aux1]
  ],
    focalPoint=[0,0],
    height=h,
    steps = 30,
    showCtlR = 0
);
        
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
    translate([i*aux2,j*aux2,thick]) cylinder(r=2.6, h=35, $fn=20);
    translate([i*30.5/2,j*30.5/2,thick]) cylinder(r=2.6, h=8, $fn=20);
}

color("lightgrey") translate([0,0,thick+35]) topPlate();
}

///curvature();
///curvature2();
///curvature3();
///curvature4();

if(RENDER_CENTRAL_PLATE==true) {
    basePlate(top=true);  
}


if(RENDER_BOTTOM_PLATE==true) {
    basePlate(top=false);  
}


if(RENDER_TOP_PLATE==true) {
    topPlate();
}





        
    
