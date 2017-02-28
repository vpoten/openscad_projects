/**
 * cinetank compatible motor mount
 */
 
 use <dronePlates.scad>
 use <honeycomb_lattice.scad>
 
 m3Rad = 3.2/2;
 height = 12.5;
 tubeD = 16.3;
 screw = 6-3;
 
 union(){
 difference(){
 hull(){
    for(i=[-1,1]) for(j=[-1,1]) {
        translate([i*22/2,j*26/2,0]) cylinder(r=5, h=height, $fn=20);
    }
 }
 
 rotate([0,0,45]) motorCircleMountHoles(0, 28, thick=screw, extraH=false, holeR=m3Rad);
 translate([0,0,screw]) rotate([0,0,45]) motorCircleMountHoles(0, 28, thick=height-screw, extraH=false, holeR=m3Rad*2);
 
 for(i=[-1,1]) for(j=[-1,1]) {
     translate([i*22/2,j*26/2,-0.5]){
         cylinder(r=m3Rad, h=height+1, $fn=20);
         hexagon(3, 0.12, 5.5);//m3 nut
     }
 }
 
 translate([0,0,height+1]) rotate([0,90,0]) cylinder(r=tubeD/2, h=100, $fn=40, center=true);
 
 cylinder(r=4.5, h=4, $fn=20);//shaft hole
 
 for(i=[-1,1]){
     translate([0,i*(26/2+6),0]) scale([1.4,1,1]) hexagon(3.5,1.75,height);
 }
 
 }//diff
 
 translate([0,0,4]) cylinder(r=5.75/2, h=3.25, $fn=20);//pin
}
 
 ///color("blue") translate([0,0,-1]) cylinder(r=28/2,h=1,$fn=20);