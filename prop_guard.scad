/**
 * propeller guard
 */

use <dronePlates.scad>

size = 6;//size in inches
centerD = 32;//center diameter
arcDeg = 110;
plateThick = 2.5;
width = 6;
m2Rad = 2.8/2;
m3Rad = 3.4/2;

module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here
    // -- sucks up all memory and spins out of control
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 50)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5])
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5])
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}//end module

/**
 *
 */
module main_arc(radius) {
difference(){
union(){
rotate([0,0,90+arcDeg*0.5]){ arc(height=width, depth=plateThick, radius=radius, degrees=arcDeg); }

//helper disk
for ( i = [-1 : 1] ) {
rotate([0,0,i*(arcDeg/2)]){ translate([radius,0,0]){helperDisk(20);} }
}
}//end union

//spacer support holes
for ( i = [-1,1] ) {
rotate([0,0,i*arcDeg/3]){
translate([radius-width/2,0,0]){ cylinder(h = plateThick, r = m3Rad, $fn=30); }
}
}
}//end diff
}//end module

/**
 *
 */
module guard(radius) {
holesAng = 45;
d0=19;
d1=16;
d2=12;

//center/mount
difference() {

union(){
rotate([0,0,holesAng]){ motorCircleMount(7, centerD, thick=plateThick, d1=d1, d2=d2, holeR=m2Rad); }

//arc
main_arc(radius);

//nerves
for ( i = [-1 : 1] ) {
rotate([0,0,i*(arcDeg/2-2.5)]){ translate([0,-width/2,0]){cube(size=[radius-width/2,width,plateThick]);} }
}

}//end union

//remove holes
for ( i = [0 : 2] ) {
	rotate([0,0,i*120]){ translate([13,0,0]){ cylinder(h = plateThick, r = m2Rad, $fn=30); } }
}
//for ( i = [0 : 2] ) {
//	rotate([0,0,i*90]){ translate([0,10,0]){cylinder(h = plateThick, r = 3.5, $fn=30);} }
//}
//rotate([0,0,holesAng]){
//motorCircleMountHoles(7, centerD, thick=plateThick, d1=d1, d2=d0, holeR=m2Rad );
//motorCircleMountHoles(7, centerD, thick=plateThick, d1=d1, d2=d2, holeR=m2Rad ); 
//}

cylinder(h = plateThick, r = d0/2+1, $fn=30);

//remove extra hole for zip-tie
translate([m2Rad+centerD/2,0,0]){ cylinder(h = plateThick, r = m2Rad, $fn=30);}

} //end diff

}//end module


radius = size*25.4*0.5;

guard(radius);
translate([radius/1.5,0,0]){ rotate([0,0,180]){ main_arc(radius); } }

