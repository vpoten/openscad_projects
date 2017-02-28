/**
 * leg pad
 */

difference(){
cube(size=[30,24,8],center=true);

translate([0,-6.6,0]){
translate([0,0,0]) cube(size=[11,11,9],center=true);
for(i=[-1,1]) translate([21/2*i,0,0]) cylinder(h = 9, r = 3.5/2, $fn=30, center=true);
}

for(i=[-1,1]) translate([21*i,12,0]) rotate([0,0,i*45]) cube(size=[20,20,9],center=true);

}
