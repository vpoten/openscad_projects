/**
 * hero3 mount for gopro hero3 ribcage mod
 *
 */

use <dronePlates.scad>
use <honeycomb_lattice.scad>

hero3W = 60;
hero3H = 42;
hero3D = 25;
m2Rad = 2.5/2;
m3Rad = 3.3/2;
bottomThick = 2;
imuZ = 4;
imuX = 8;
motorRad = m3Rad;

/**
 *
 */
module imuHoles(){
for( i=[0,1] ){
translate([imuX,-22,imuZ+15*i])
rotate([90,0,0]) cylinder(r = 1.6, h = 100, center = true, $fn=30); 
}

//imu zip-tie groove
for(i=[-1,1]) translate([imuX,i*21,11]){ cube([3,2,15], center=true); }
}// end module


/**
 *
 */
module protrude(){
rad=4.85;
len=6;
hpro=0;
hproInt = 2.75;
slotDst = 16/2;

rotate([90,0,0])
union(){
cube(size=[len+motorRad*2,hpro,rad*2+2],center=true);
for(i=[-1,1]) translate([i*len/2,0,0]) rotate([90,0,0]) cylinder(r = rad, h = hpro, center = true, $fn=20);
}


for(i=[-1,1])
translate([0,slotDst*i,0])
rotate([90,0,0])
union(){
cube(size=[len,6,motorRad*2],center=true);
for(i=[-1,1]) translate([i*len/2,0,0]) rotate([90,0,0]) cylinder(r = motorRad, h = 6, center = true, $fn=20);
}

for(i=[-1,1])
translate([0,slotDst*i,2.75])
rotate([90,0,0])
union(){
cube(size=[len,hproInt,(motorRad+2)*2],center=true);
for(i=[-1,1]) translate([i*len/2,0,0]) rotate([90,0,0]) cylinder(r = motorRad+2, h = hproInt, center = true, $fn=20);
}

}// end module

difference(){
roundedRect([hero3W+3,hero3H+3,hero3D+5], 4);

translate([0,0,(hero3D+5)/2+bottomThick]) cube(size=[hero3W,hero3H,(hero3D+5)], center=true);

for(i=[-1,1]) translate([0,i*hero3H/2,(hero3D+30)/2]) cube(size=[hero3W+10,12,10], center=true);

translate([-hero3W/2,-hero3H/2+1,-0.5]) intersection(){ 
	honeycombLattice(5, 4, 5, 2, bottomThick+1, 3, fillHalves=true);
	cube(size=[hero3W-2,hero3H-3,hero3D]);
}

translate([hero3W/2-1,-(hero3H-10)/2,bottomThick]) cube(size=[10,hero3H-10,hero3D+5]);
imuHoles();

color("blue") translate([-(hero3W/2)-3,0,hero3D-5]) rotate([0,90,0]) protrude();

translate([hero3W/2,0,20]) rotate([0,35,0]) cube(size=[hero3W/2,hero3H+10,hero3D/2], center=true);

//side hexagons
for(j=[-1,1]){
translate([-13,j*(hero3H/2),12]) for(i=[-1,1]){ rotate([90,0,0]) translate([9*i,0,-5]) rotate([0,0,30]) hexagon(5,1,10); }
}
}

 
