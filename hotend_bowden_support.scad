/**
 * hotend support
 */

m3Rad = 3.5/2;
m5Rad = 5.6/2;
toCarrDist= 65;
toHotDist= 50;
holeRad=11;
boxH=15;

/**
 *
 */
module helperDisk(diameter) {
	cylinder(r = diameter/2, h = 0.6, $fn=20);
}

union(){

translate([0,0,15])
rotate([90,0,0])
difference(){

union(){
cube(size=[80,30,boxH],center=true);
translate([0,-5,boxH/2+4.5]) cube(size=[holeRad*2+8,20,9],center=true);
}

for(i=[-1,1]){
translate([i*toCarrDist/2,0,0]) rotate([90,0,0]) cylinder(r=m3Rad,h=50,center=true,$fn=20);
translate([i*17,0,0]) rotate([90,0,0]) scale([1.1,1.5,1]) cylinder(r=m5Rad,h=50,center=true,$fn=20);
translate([i*toHotDist/2,0,0]) cylinder(r=m5Rad,h=50,center=true,$fn=20);
}

cylinder(r=m5Rad,h=50,center=true,$fn=20);
cylinder(r=holeRad,h=15,center=true,$fn=20);
translate([0,0,1.5]) cube(size=[holeRad*2,50,boxH-3],center=true);
translate([0,10,1.5]) cube(size=[holeRad*2+20,10,boxH-3],center=true);


//nut pocket
translate([0,0,boxH+1]) cylinder(r=4.3,h=1.15,center=true,$fn=20);
translate([0,0,boxH-3.25]) cube(size=[8.5,50,5.5],center=true);
translate([0,5,boxH+1]) cube(size=[4,7,3],center=true);

}//diff

for(i=[-1,1]) for(j=[-1,1]) translate([i*44,j*12,0]) helperDisk(22);

}

