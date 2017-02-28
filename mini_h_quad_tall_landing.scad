/**
 * mini quad tall landing skid
 */

use <dronePlates.scad>;

m3Rad = 3.4/2;
height = 10;
diameter = 30;
thick = 2;
nerve = 2.7;
scaleZ = 0.667; //(heigth/(diameter/2))

/**
 *
 */
module ellipsoid(){
scale([1,1,scaleZ])
difference(){
sphere(r = diameter/2, $fn=40);
translate([0,0,-diameter/2]) cube(size=[diameter,diameter,diameter], center=true);

}//diff
}//end module

/**
 *
 */
module roundedCube(size, rad){
minkowski()
{
 cube(size, center=true);
 sphere(r = rad, $fn=20);
}
}//end module


difference(){

rotate([0,0,45]) ellipsoid();

rotate([0,0,45]) for(i=[-1,1]) for(j=[-1,1]){
translate([i*(20/2+nerve+1),j*(20/2+nerve+1),height/2+2+thick]) roundedCube([20,20,height],rad=2);
}

motorCircleMountHoles(0, diameter, thick=thick, d1=19, d2=16, holeR=m3Rad);

}//diff




