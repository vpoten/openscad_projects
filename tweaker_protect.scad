/**
 * tweaker front/bottom protector
 */
 
use <dronePlates.scad>;
use <honeycomb_lattice.scad>;

m3Rad = 3.5/2;
thick = 3;


//translate([20,0,0]) cube(size=[2,36,2], center=true);
//translate([-2,20,0]) cube(size=[20,2,2], center=true);

difference(){
roundedRect([22,33,thick], 3);

for(i=[-1,1]){
translate([7.5,i*27/2,-0.5]) cylinder(r=m3Rad, h=thick+1, $fn=20);
translate([7.5,i*27/2,thick/2]) cylinder(r=m3Rad*2, h=thick/2, $fn=20);
///translate([-3,i*8,-0.5]) hexagon(4.5,2,thick+1);
}

translate([0,0,-0.5]) hexagon(5,2,thick+1);
}

