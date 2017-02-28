module helperDisk(diameter) {
translate([0, 0, 0.3]) {
	cylinder(r = diameter/2, h = 0.6, center = true);
}
}


union(){

difference() {
	rotate(a=[0,0,-90]) {
	translate([-6,0,0]) {
		import("/home/victor/Escritorio/3d_models/BL_Tricopter/BL_Tricopter_TOP_Plate.STL");
	}
	}
	//make landing gear holes
	translate([26.5,37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
	translate([26.5,-37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
	translate([-52.5,37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
	translate([-52.5,-37,0]) {cylinder (h = 12, r=1.505, center = true, $fn=100);}
}

//front
translate([71,46,0]) { helperDisk(20); }
translate([71,16,0]) { helperDisk(20); }
translate([52,55,0]) { helperDisk(20); }

translate([60,-49,0]) { helperDisk(20); }

//middle
translate([30,57,0]) { helperDisk(20); }
translate([30,-57,0]) { helperDisk(20); }

translate([-14,63,0]) { helperDisk(20); }
translate([-14,-63,0]) { helperDisk(20); }

//back
translate([-79,20,0]) { helperDisk(20); }
translate([-79,-20,0]) { helperDisk(20); }

translate([-55,52,0]) { helperDisk(20); }
translate([-55,-52,0]) { helperDisk(20); }

}