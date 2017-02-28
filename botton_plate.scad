
//add holes
difference() {
	import("/home/victor/Escritorio/3d_models/BL_Tricopter/BL_Tricopter_BOTTOM_Plate.STL");
	translate([26.5,37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
	translate([26.5,-37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
	translate([-52.5,37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
	translate([-52.5,-37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
}