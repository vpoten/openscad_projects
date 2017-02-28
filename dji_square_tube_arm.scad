/**
 * dji flamewheel square tube arm adapter
 *
 * GNU GPL V3
 * @author: Victor Potenciano
 */

use <dronePlates.scad>


m3Rad = 3.25/2;
height = 37;
l2 = 38;
l1= 30;
sqTubeT = 12.8;
tubeCover = 3.5;
rbHeight = height-sqTubeT-tubeCover*2-tubeCover/2;
bhHeight = height-sqTubeT-tubeCover*2-tubeCover/2;
shift = 6;
fixHoleD = 30;
holesR = 4.5;

/**
 *
 */
module djiNutSlot() {
	a = 23;
	a1 = 21;
	b = 16;
	c = 19.5;

	for(i=[-1,1]){
	translate([i*(a/2+0.3), c/2, 4]) { cube(size=[7,5.4,2.5], center=true); }
	translate([i*b/2, -c/2, 0]) { cube(size=[5.4,6.7,2.5], center=true); }
	translate([i*(a1/2-0.7), c/2, -rbHeight+4]) { cube(size=[7.3,5.4,2.5], center=true); }
	}
}

module main() {
difference(){

translate([-l1/2,-l2*0.5+shift,0]){ cube(size=[l1,l2,height]); }

translate([0,0,rbHeight]){ djiFlamewheelHoles(25+1); }
djiFlamewheelHolesBotton(12);

//square tube hole
translate([0,0,height-sqTubeT*0.5-tubeCover]){ cube(size=[sqTubeT+0.2,l2+20,sqTubeT+0.2], center=true); }

//remove botton back
translate([0,-l2*0.25+shift-1,rbHeight/2]){ cube(size=[l1+10,l2/2+0.1,rbHeight+0.1], center=true); }

//remove botton hole
translate([0,-l2*0.25,bhHeight/2]){ cube(size=[l1/2-1.5,l2+40,bhHeight+0.1], center=true); }

//tube fix hole
translate([0,-l2/2+shift+fixHoleD,height-tubeCover-sqTubeT*0.5]){
	rotate([0,90,0]){cylinder(h = l1+10, r = m3Rad, $fn=30, center=true);}
	rotate([0,90,0]){cylinder(h = 2, r = 2.75, $fn=30, center=true);}
}
translate([l1/2-1,-l2/2+shift+fixHoleD,height-tubeCover-sqTubeT*0.5]){
	rotate([0,90,0]){cylinder(h = 2.1, r = 3.0, $fn=30, center=true);}
}
translate([-l1/2+1.23,-l2/2+shift+fixHoleD,height-tubeCover-sqTubeT*0.5]){
	cube(size=[2.5,5.4,6.4], center=true);
}

//center holes
translate([0,0,height/2]){
	cylinder(h = height+1, r = holesR, $fn=30, center=true);
}

translate([0,0,height-tubeCover-sqTubeT*0.5]){
	rotate([0,90,0]){cylinder(h = l1+1, r = holesR, $fn=30, center=true);}
}

translate([0,-l2/2+shift+fixHoleD,height/2]){
	cylinder(h = height+1, r = holesR, $fn=30, center=true);
}

//m3 nut slot
translate([0,0,rbHeight+tubeCover*0.75]){ djiNutSlot(); }

}//diff
}//module

translate([-21,0,0]){ main(); }
translate([21,0,0]){ main(); }
