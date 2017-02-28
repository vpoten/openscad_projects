//////////////////////////////////////////
// tbs discovery FPV top camera mount, LEFT SIDE, LONGER ARM, V2
//////////////////////////////////////////

module helperDisk(diameter) {
translate([0, 0, 0.3]) {
	cylinder(r = diameter/2, h = 0.6, center = true);
}
}

totalL = 120;
plateThick = 3.25;
frameThick = 10;
m3Rad = 3.4/2;
frameHoleD = 40;
frameH=21;
nholes=3;

translate([0,0,frameThick/2]){//translate all
rotate([0,90,0]){

translate([0,0,plateThick/2]){

difference(){
cube(size = [frameThick,totalL,plateThick], center = true);

for(i=[0:nholes]){
translate([0,totalL/2-4-i*frameHoleD/2,0]){ cylinder(h = 5, r=m3Rad, $fn=30, center=true); }
}

}//diff
}//translate

translate([0,-(totalL/2-15-plateThick/2),frameH/2]){
for(i = [-1,1]){
translate([0,i*(15+plateThick/2),0]){ 
	difference(){
	cube(size = [frameThick,plateThick,frameH], center = true); 
	translate([0,0,frameH/2-4]){ rotate([90,0,0]){cylinder(h = 5, r=m3Rad, $fn=30, center=true);} }
	}//diff
}
}

}//translate

}//rotate
}//translate all

for(i=[-1,1]){
translate([0,i*(totalL/2),0]) { helperDisk(20); }
}


