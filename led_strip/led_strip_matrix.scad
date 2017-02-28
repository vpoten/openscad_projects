/**
 * led strip matrix
 */
rows = 5;
cols = 2;
width = 13;
length = 100;

module line(){
	translate([length/2,width/2,0]) import("led_strip_5050_single_line.stl");
}

for(i=[0:rows-1]) for(j=[0:cols-1]){
translate([j*length,i*width,0]) line();
}
