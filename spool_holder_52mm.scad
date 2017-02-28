/**
 * Spool holder
 */

use <dronePlates.scad>;

diam = 52;
height = 70;
bearingDia = 22.3;

difference(){

cylinder(r=diam/2, h=height, $fn=20);

translate([0,0,7]) tube(bearingDia+6, diam-8, height);
translate([0,0,4]) cylinder(r=bearingDia/2, h=height, $fn=40);
translate([0,0,12]) cylinder(r=29/2, h=height, $fn=20);
cylinder(r=8.3/2, h=70, $fn=20);

for(i=[0:2]){
rotate([0,0,i*120]) translate([diam/2-8,-25/2,7]) cube(size=[25,25,70]);
rotate([0,0,i*120]) translate([diam/2-7,0,0])  cylinder(r=4.5, h=height, $fn=20);
}

}//diff

