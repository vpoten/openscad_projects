/** 
 * tweaker mobius simple mount
 */

use <dronePlates.scad>;
use <honeycomb_lattice.scad>;

m3Rad = 3.2/2;
angle=20;
length=45;
width=32;
thick=2;
angle2=75;



///translate([45,0,0]) cube(size=[5,5,12]); //probe

difference(){

intersection(){
roundedRect([length,32,30], 4);
rotate([0,angle,0]) translate([0,0,-25+19]) cube(size=[100,50,50], center=true);
}

//holes
for(i=[-1,1]) for(j=[-1,1]) {
translate([i*40/2,j*27/2,0]) cylinder(r=m3Rad, h=90, $fn=20, center=true);
}

for(i=[-1,1]){
translate([length/2,i*width/2,thick]) roundedRect([32,10,50], 4);
//translate([length/2-13,i*width/2,0]) roundedRect([7,10,50], 4);
translate([40/2-10,i*27/2,0]) rotate([-i*angle2/2,0,0]) cylinder(r=m3Rad, h=90, $fn=20,center=true);
}

translate([-length/2,0,50/2+thick]) cube(size=[14,50,50], center=true);
translate([-length/2,0,0]) roundedRect([16,15,50], 4);

translate([0,0,15])
rotate([90,angle,0]) {
difference(){
translate([4,0,-30]) hexagon(7,4,60);
translate([-50/2,0,-35])cube(size=[50,20,70]);
}
}//end transversal

hexagon(4,2,10);

}//diff

//antenna holder
difference(){

for(i=[-1,1]){
translate([40/2-10,i*27/2,0]) rotate([-i*angle2/2,0,0]) tube(m3Rad*2, 7.5, 13);
}

translate([0,0,-10/2]) cube(size=[100,100,10], center=true);
for(i=[-1,1]){
translate([40/2-10,i*27/2,10/2+8]) cube(size=[10,25,10], center=true);
}

}//diff
