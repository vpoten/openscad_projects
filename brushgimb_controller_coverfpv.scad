/**
 * brushless gimbal controller cover plate + fpv_cam holder
 */

use <dronePlates.scad>

m3Rad = 3.5/2;
m5Rad = 5.5/2;
m6Rad = 6.5/2;
fpvCamAng = 5;
contrMntDist = 45;
hdisk=22;
plateThick=2;

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

difference(){
union(){
for(i=[-1,1]) for(j=[-1,1]){ 
	translate([i*contrMntDist/2,j*contrMntDist/2,0])
	tube(m3Rad*2,7,plateThick+8);
}

crossSquarePlate(contrMntDist, thick=plateThick);

translate([-(contrMntDist+8)/2,0,0]) roundedRect([10,21,plateThick], 3);


for(i=[-1,1]) for(j=[-1,1]){ 
	translate([i*(contrMntDist+10)/2,j*(contrMntDist+10)/2,0]) helperDisk(hdisk);
}
}//union

translate([-(contrMntDist+10)/2,0,0]) roundedRect([1,16,plateThick], 1.5);

}//diff

translate([0,55,3]) rotate([90,0,0]) cameraPlate();

