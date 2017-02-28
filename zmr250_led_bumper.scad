/**
 * WS2812B 8 led bumper
 */
 
use <dronePlates.scad>;

holeDist = 32;
spacerDia = 6.4;
thick = 2.5;

difference(){
union(){
for(i=[-1,1]) translate([i*holeDist/2,0,0]){
    cylinder(r=(spacerDia+5)/2,h=10,$fn=20);
    translate([0,-(spacerDia+5)/4,5]) cube(size=[spacerDia+5,(spacerDia+5)/2,10], center=true);
    }
    
translate([0,-(spacerDia/2+thick/2),5]) cube(size=[51,thick,10], center=true);
}//union

for(i=[-1,1]) translate([i*holeDist/2,0,0]){
    cylinder(r=spacerDia/2,h=10,$fn=40);
}
}