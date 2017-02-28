/**
 * zmr250 gopro conversion kit
 */
 
 use <BezierScad/BezierScad.scad>;
 use <dronePlates.scad>
 
 armThick = 3;
 plateThick = 1.5;
 topThick = 4;
 holeDst = 32;
 m3Rad = 3.3/2;
 angle = 15;
 frontCtrY = 71;
 frontCtrX = 46;
 maxWidthBz = 11;
 wedgeW = 35;
 spacerH = 40;
 zmrSpacerH = 35;
 spacerAdd = spacerH - zmrSpacerH - plateThick;
 
 
 RENDER_PARTS = false;
 
/**
 *
 */
module goPro() {
	cube([59,21,41], center=true);
	translate([-15,15,8]) rotate([90,0,0]) cylinder(h=10, r=11, $fn=20, center=true);
}// end module

/**
 *
 */
module limits() {
    for(i=[0,35]) translate([10,0,i]) cylinder(r=1, h=armThick+1, $fn=20);
    translate([-18,0,0]) cylinder(r=1, h=armThick, $fn=20);
    for(i=[-1,1]){
    translate([-15,i*holeDst/2,0]) cylinder(r=1, h=armThick, $fn=20);
    }
}// end module

/**
 *
 */
module curvature(h = armThick){
BezWall([
  [frontCtrX, -frontCtrY/2],
  [0, -(frontCtrY+10)/2],
  [-20, -24],
  [-15,0],
  [-20, 24],
  [0, (frontCtrY+10)/2],
  [frontCtrX, frontCtrY/2]
  ],  
    widthCtls = [maxWidthBz, 5, maxWidthBz], 
    height = h, 
    steps = 24,
    centered = true
); 
}//end module

/**
 *
 */
module wedge(w, h, ang){
    rotate([90,0,0])
    linear_extrude(height = h, center=true){
        polygon( points=[ [0,0],[w,0],[w,(w/cos(ang))*sin(ang)] ] );
    }
}//end module

/**
 *
 */
module screwHoles(){
    for(i=[-1,1]){ 
    translate([-51.5,i*34/2,-0.5]) cylinder(r=m3Rad, h=armThick+5, $fn=20);
    translate([0,i*holeDst/2,-0.5]) cylinder(r=m3Rad, h=armThick+5, $fn=20);
    translate([frontCtrX,i*frontCtrY/2,-2]) cylinder(r=m3Rad, h=armThick+plateThick+3, $fn=20); 
    }
    
}//end module

/**
 *
 */
module base(){
difference(){
union(){
hull(){
for(i=[-1,1]){ translate([frontCtrX+5,i*frontCtrY/2,0]) cylinder(r=maxWidthBz/2, h=armThick, $fn=20); }
curvature();
}//hull

for(i=[-1,1]){ translate([frontCtrX,i*frontCtrY/2,0]) cylinder(r=maxWidthBz/2, h=armThick+plateThick, $fn=20); }

translate([23,0,armThick]) wedge(22,wedgeW,angle);
translate([18,0,armThick+20]) rotate([0,90,0]) wedge(20,wedgeW,angle);
translate([18-4/2,0,armThick+20/2])  cube(size=[4,wedgeW,20], center=true);
}//union
 
screwHoles();
for(i=[-1,1]){ translate([29.5+(i*34/2),-4,-0.5]) roundedRect([1.5,16,armThick+1],1); 
    translate([29.5,i*50/2,-0.5]) roundedRect([18,5,armThick+1],2);
    }
    
translate([-22,0,armThick/2]) cube(size=[20,100,armThick],center=true);
    
}//diff
}//end module

/**
 *
 */
module top(){
difference(){
union(){
    for(i=[-1,1]){ translate([frontCtrX,i*frontCtrY/2,0]) cylinder(r=maxWidthBz/2, h=topThick, $fn=20); }
    curvature(h=topThick);
    hull(){
        for(i=[-1,1]){ translate([0,i*holeDst/2,0]) cylinder(r=maxWidthBz/2, h=spacerAdd+topThick, $fn=20);
    }
}

intersection(){
    hull(){curvature(h=topThick);}
    translate([0,0,topThick/2]) cube(size=[20,100,topThick],center=true);
}
}

screwHoles();

translate([-16,0,topThick/2]) cube(size=[20,100,topThick],center=true);
translate([22,0,0]) roundedRect([22,57,topThick],4);
}//diff
}//end module


if( RENDER_PARTS==true ){
    base();
     translate([-65,0,0]) top();
}
else{
    base();
    translate([0,0,topThick+armThick+plateThick+spacerH]) rotate([180,0,0]) top();
    color("blue") for(i=[-1,1]) translate([frontCtrX,i*frontCtrY/2,armThick+plateThick]) cylinder(r=3, h=spacerH, $fn=20);
    color("red") limits();
    color("silver") translate([28,0,27]) rotate([0,-angle,0]) rotate([0,0,-90])goPro();
}
    

