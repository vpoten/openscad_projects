/** 
 * tweaker mobius simple mount v2
 */

use <dronePlates.scad>;
use <honeycomb_lattice.scad>;

m3Rad = 3.3/2;
angle=10;
length=45;
width=32;
thick=2;
angle2=75;
font1="DejaVu Sans Mono";


///translate([45,0,0]) cube(size=[5,5,12]); //probe

difference(){

union(){
translate([-(length/2-3),0,0]) roundedRect([6,32,thick], 4);
translate([(length/2-7.5),0,0]) roundedRect([15,32,thick], 4);

intersection(){
roundedRect([length,16,30], 4);
rotate([0,angle,0]) translate([0,0,-25+10.5]) cube(size=[100,50,50], center=true);
}
}//union

//holes
for(i=[-1,1]) for(j=[-1,1]) {
translate([i*40/2,j*27/2,0]) cylinder(r=m3Rad, h=90, $fn=20, center=true);
}

for(i=[-1,1]){
translate([40/2-10,i*27/2,0]) rotate([-i*angle2/2,0,0]) cylinder(r=m3Rad, h=90, $fn=20,center=true);
}

//transversal half hexagon
translate([-7,0,9/*10*/])
rotate([90,angle,0]) {
difference(){
translate([4,0,-30]) scale([1,0.5/*0.6*/,1]) hexagon(7,3,60);
translate([-50/2,0,-35])cube(size=[50,20,70]);
}
}//end transversal


translate([-4,0,0]) hexagon(4,2,6);
translate([16,0,0]) hexagon(3,2,12);

//height cut
translate([0,0,25+18.5]) cube(size=[100,50,50], center=true);

//text
translate([-18,-2.5,17.5]) rotate([0,angle,0]) linear_extrude(height=0.3) text("Tweaker",size=5, font=font1);
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

///translate([0,50,0]) rotate([0,angle,0]) linear_extrude(height=1) text("Tweaker",size=6, font=font1);

