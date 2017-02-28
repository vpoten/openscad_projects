/**
 * sma antenna extension mount inside f450 arms hub hole
 */

use <dronePlates.scad>;

m3Rad = 3.4/2;
plateThick = 1.5;

difference(){
union(){
hull(){
scale([1.15,1.15,1]) djiFlamewheelHoles(plateThick);
}

cylinder(r=10/2, h=5, $fn=30);

}//union

djiFlamewheelHoles(plateThick);
cylinder(r=7.1/2, h=10, center=true, $fn=30);
}


