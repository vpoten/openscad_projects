//////////////////////////////////////////
// dji flamewheel FPV top camera mount
//////////////////////////////////////////

/**
 *
 */
module helperDisk(diameter) {
	cylinder(r = diameter/2, h = 0.6);
}

/**
 *
 */
module roundedRect(size, radius) {
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull() {
	// place 4 circles in the corners, with the given radius
	translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0]){ circle(r=radius); }
	translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0]){ circle(r=radius); }
	translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0]){ circle(r=radius); }
	translate([(x/2)-(radius/2), (y/2)-(radius/2), 0]){ circle(r=radius); }
	}
}


plateL = 34;
camHoleD = 27.5;
m3Rad = 3.2/2;
holeT = (plateL-camHoleD)/2;
frameHeight = 30;
holeRad = 10.5;
plateThick = 3.25;
interDist = 25;

union(){

difference(){
cube(size = [plateL,plateL,plateThick], center = false);

//main hole
translate([plateL/2,plateL/2,-1]){ cylinder(h = 5, r=holeRad, $fn=100); }

//cam holes
translate([holeT,holeT,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
translate([holeT,holeT+camHoleD,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
translate([holeT+camHoleD,holeT,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
translate([holeT+camHoleD,holeT+camHoleD,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
}

difference(){
translate([-plateThick-2,0,0]){ cube(size = [plateThick,plateL,frameHeight], center = false); }

translate([-2,plateL/2-interDist/2,frameHeight-6]){
rotate([0,90,0]){ cylinder(h = 7, r=m3Rad, $fn=100, center=true); }
}
translate([-2,plateL/2+interDist/2,frameHeight-6]){
rotate([0,90,0]){ cylinder(h = 7, r=m3Rad, $fn=100, center=true); }
}

translate([-2,plateL/2,frameHeight/2]){
rotate([0,90,0]){ cylinder(h = 7, r=7.5, $fn=100, center=true); }
}

}//end diff

translate([-2,0,0]){ cube(size = [2,plateL,plateThick], center = false); }

//helper disks
translate([39,39,0]) { helperDisk(18); }
translate([39,-5,0]) { helperDisk(18); }
translate([-8,38,0]) { helperDisk(18); }
translate([-8,-4,0]) { helperDisk(18); }

}//end union

baseThick = plateThick-1.5;
translate([15,-17,0]){ 

difference(){	 
	union(){
	roundedRect([28,5,plateThick],4.8);
	translate([0,0,baseThick/2]){cube(size = [plateL+6,18,baseThick], center = true);}
	}

	translate([-interDist/2,0,0]){ cylinder(h = 7, r=m3Rad, $fn=100, center=true); }
	translate([interDist/2,0,0]){ cylinder(h = 7, r=m3Rad, $fn=100, center=true); }
}//end diff
}
