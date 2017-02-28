/**
 * rigid motor mount
 */

use <dronePlates.scad>

m3Rad = 3.5/2;
m5Rad = 5.5/2;
m6Rad = 6.5/2;
fpvCamAng = 5;

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

	//for(i=[-1,1]) translate([6*i,0,-4]){ 
	//cube(size=[m3Rad*4,12,m3Rad*2], center=true);
	//translate([0,0,-3])cylinder(h=8,r=m3Rad,$fn=20,center=true);
	//}
}//diff

}// end module



translate([0,0,5])
difference(){
union(){
	difference(){
	union(){
	translate([0,0,-2.5]) cube(size=[50,37,5], center=true);
	cube(size=[40,37,10], center=true);
	}
	cube(size=[30,27,15], center=true);
	}//diff

	for(i=[-1,1]) translate([i*20,0,0]) rotate([90,0,0]) cylinder(r=5, h=37, $fn=20, center=true);

	
	translate([20,-3,5])
	hull(){ 
		for(i=[-1,1]) for(j=[-1,1]) translate([i*7.5,j*7.5,0]) cylinder(r=4, h=20, $fn=30, center=true);
	}//hull

	//fpv cam extension
	translate([-45,-16,0]) cube(size=[50,5,10], center=true);
	translate([-25,-13,-4.25])  cylinder(r=5, h=1.5, $fn=30, center=true);

	translate([-56.2,-17,-2]) rotate([0,0,180]) rotate([90,0,0]) cameraPlate();

	///translate([20,-3,5]) cylinder(r=14, h=20, $fn=30, center=true);
}//union

	for(i=[-1,1]) translate([i*20,0,0]) rotate([90,0,0]) cylinder(r=m3Rad, h=40, $fn=20, center=true);
	
	translate([20,-3,-10])  rotate([0,0,45]) motorCircleMountHoles(7, 28, thick=30, d1=19, d2=16);
	translate([20,-3,-5])  rotate([0,0,45]) motorCircleMountHoles(7, 28, thick=15.5, d1=19, d2=16, holeR=m6Rad);

	//fpv camera support holes
	///translate([-58,-16,0])
	///for(i=[-1,1]) translate([6*i,0,0]) rotate([90,0,0]) cylinder(h=8,r=m3Rad,$fn=20,center=true);

}//diff

//helper disks
for(i=[-1,1]) translate([i*28,22,0]) helperDisk(20);
translate([28,-22,0]) helperDisk(20);
translate([-75,-16,0]) helperDisk(22);


