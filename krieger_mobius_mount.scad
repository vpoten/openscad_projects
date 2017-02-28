/**
 * krieger mobius mount
 */
 
 use <dronePlates.scad>
 
 m3Rad = 3.4/2;
 spacerDia = 5.4;
 angle2 = 70;
 
 difference(){
 union(){
 translate([0,0,(spacerDia+4)/2]) roundedRect([55,37,3],3);
 for(i=[-1,1]) translate([i*30/2,0,0]){
     hull(){
     rotate([90,0,0]) cylinder(r=(spacerDia+4)/2, h=40, $fn=30, center=true);
     translate([0,0,(spacerDia+4)/2]) cube(size=[spacerDia+4,40,3],center=true);
     }
 }
 
for(i=[-1,1]){
translate([25,i*14/2,-5]) rotate([-i*angle2/2,0,0]) cylinder(r=7.5/2, h=19, $fn=20);
}
}
 
 for(i=[-1,1]) translate([i*30/2,0,0]){rotate([90,0,0]) cylinder(r=spacerDia/2, h=41, $fn=30, center=true);}
 
 translate([0,0,-0.4]) cube(size=[40,18,10], center=true);

//antenna 
for(i=[-1,1]){
translate([25,i*14/2,-5]) rotate([-i*angle2/2,0,0]) cylinder(r=m3Rad, h=90, $fn=20,center=true);
}

for(i=[-1,1]){
    translate([i*20,0,0]) cylinder(r=6,h=20,center=true);
    translate([0,i*40/2,0]) cylinder(r=10,h=20,center=true);
}
 
translate([0,0,12]) cube(size=[100,100,10], center=true);
translate([25,0,-5]) cube(size=[10,100,10], center=true);
}//diff