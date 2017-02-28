//////////////////////////////////////////
// tbs discovery FPV top camera mount
//////////////////////////////////////////

module helperDisk(diameter) {
translate([0, 0, 0.3]) {
	cylinder(r = diameter/2, h = 0.6, center = true);
}
}


plateL = 34;
camHoleD = 27.5;
m3Rad = 3.02/2;
holeT = (plateL-camHoleD)/2;
frameHoleD = 40;
frameThick = 8;

union(){

difference(){
cube(size = [plateL,plateL,3], center = false);

//main hole
translate([plateL/2,plateL/2,-1]){ cylinder(h = 5, r=9.5, $fn=100); }

//cam holes
translate([holeT,holeT,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
translate([holeT,holeT+camHoleD,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
translate([holeT+camHoleD,holeT,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
translate([holeT+camHoleD,holeT+camHoleD,-1]){ cylinder(h = 5, r=m3Rad, $fn=100); }
}

difference(){
translate([-3,-frameHoleD-m3Rad*4,0]){ cube(size = [3,plateL+frameHoleD+m3Rad*4,frameThick], center = false); }

translate([0,-m3Rad*2,frameThick/2]){ rotate([0,90,0]){cylinder(h = 10, r=m3Rad, $fn=100, center = true);} }
translate([0,-(m3Rad*2+frameHoleD),frameThick/2]){ rotate([0,90,0]){cylinder(h = 10, r=m3Rad, $fn=100, center = true);} }
}

//helper disks
translate([39,39,0]) { helperDisk(18); }
translate([39,-5,0]) { helperDisk(18); }
translate([-8,39,0]) { helperDisk(18); }
translate([-2,-51,0]) { helperDisk(18); }
translate([-2,-16,0]) { helperDisk(18); }

}//end union