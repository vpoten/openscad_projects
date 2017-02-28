//////////////////////////////////////////
// tbs discovery FPV top camera mount, LEFT SIDE
//////////////////////////////////////////

module helperDisk(diameter) {
translate([0, 0, 0.3]) {
	cylinder(r = diameter/2, h = 0.6, center = true);
}
}


plateL = 34;
camHoleD = 27.5;
m3Rad = 3.2/2;
holeT = (plateL-camHoleD)/2;
frameHoleD = 40;
frameThick = 12;
plateThick = 3.25;
holeRad = 10.5;
angle = 7.5;

mirror([ 0, 1, 0 ]) {
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
}//end diff

translate([-2,0,0]){ cube(size = [2,plateL,plateThick], center = false); }

translate([-1,0,0]){
difference(){

rotate([0,-angle,0]){
difference(){
translate([-plateThick,-frameHoleD-m3Rad*4,0]){ cube(size = [plateThick,plateL+frameHoleD+m3Rad*4,frameThick], center = false); }

translate([0,-m3Rad*2,frameThick/2]){ rotate([0,90,0]){cylinder(h = 10, r=m3Rad, $fn=100, center = true);} }
translate([0,-(m3Rad*2+frameHoleD),frameThick/2]){ rotate([0,90,0]){cylinder(h = 10, r=m3Rad, $fn=100, center = true);} }
}//end difference
}//end rotate

translate([-50,-50,-2]){ cube(size = [100,100,2], center = false);}
translate([-50,-50,frameThick-1]){ cube(size = [100,100,2], center = false);}
}//end difference
}

//helper disks
translate([38,38,0]) { helperDisk(18); }
translate([38,-5,0]) { helperDisk(18); }
translate([-8,38,0]) { helperDisk(18); }
translate([-2,-50,0]) { helperDisk(18); }
//translate([-2,-16,0]) { helperDisk(18); }

}//end union
}//end mirror
