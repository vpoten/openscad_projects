/**
 * TBS discovery gps electronics plate
 *
 */

use <dronePlates.scad>


m3Rad = 3.5/2;
plateThick = 3;
conTubeThick = 2;

difference(){
union(){
	crossSquarePlate(32);

	//tubes for crossplate 2
	for(i=[-1,1]) for(j=[-1,1]){ translate([i*32/2, j*32/2, 0]) tube(m3Rad*2, 7, plateThick+3); }

	
	for(i=[-1,1]) translate([0,i*29,plateThick/2]) cube([8,25,plateThick],center=true);
		
}//union

for(i=[-1,1]) translate([0,i*68/2,0]) cube([m3Rad*2,8,10],center=true);

}//diff

//helper disks
for(i=[-1,1]) for(j=[-1,1]) translate([i*21,j*21,0]) { helperDisk(18); }
for(j=[-1,1]) translate([0,j*45,0]) { helperDisk(18); }

