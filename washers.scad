/**
 * washers
 *
 */
use <dronePlates.scad>
inRad = 6.8/2;
dia = 12;
thick = 1.2;
shift=15;

rows = 2;
cols = 2;

for(i=[0:rows-1]) for(j=[0:cols-1]){
	translate([j*shift,i*shift,0]) tube(inRad*2, dia, thick);
}
