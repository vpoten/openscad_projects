//////////////////////////////////////////
// dji flamewheel GoPro camera mount
//////////////////////////////////////////

/**
 *
 */
module helperDisk(diameter) {
	cylinder(r = diameter/2, h = 0.6);
}

/**
 *
 */
module roundedRect(size, radius) {
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull() {
	// place 4 circles in the corners, with the given radius
	translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0]){ circle(r=radius); }
	translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0]){ circle(r=radius); }
	translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0]){ circle(r=radius); }
	translate([(x/2)-(radius/2), (y/2)-(radius/2), 0]){ circle(r=radius); }
	}
}


/**
 *
 */
module tube(inDia, outDia, height) {
	difference(){
		cylinder(h = height, r = outDia/2, $fn=30);
		translate([0, 0, -0.5]) { cylinder(h = height+1, r = inDia/2, $fn=30); }
	}
}

plateThick = 4;
m3Rad = 3.4/2;
protrude=1.5;

union(){

difference(){
import("/home/victor/Escritorio/3d_models/GoPro_Hero3_Mount_For_Spyda_500_Quadcopter/GoPro_Spyda_500_Mount.stl");
translate([-15,-60,0]){ cube(size=[30,30,plateThick]); }
}//diff

translate([0,-30,0]){ //connection module
difference(){
union(){
roundedRect([31,20,plateThick], 4);
translate([12,-7,0]){ tube(m3Rad*2,10,plateThick+protrude); }
translate([-12,-7,0]){ tube(m3Rad*2,10,plateThick+protrude); }
}//union

//holes
translate([12,-7,0]){ cylinder(h = 12, r = m3Rad, $fn=30, center=true); }
translate([-12,-7,0]){ cylinder(h = 12, r = m3Rad, $fn=30, center=true); }
translate([-6,-12.5,0]){cube(size=[12,11,plateThick]);}
}//diff
}//connect

translate([-30,-20,0]){//bracket
rotate([0,0,90]){
difference(){
roundedRect([35,15,plateThick-0.5], 4);

//holes
translate([12,-5,0]){ cylinder(h = 12, r = m3Rad, $fn=30, center=true); }
translate([-12,-5,0]){ cylinder(h = 12, r = m3Rad, $fn=30, center=true); }
translate([-6,-10,0]){cube(size=[12,11,plateThick]);}
}//diff
}
}//bracket

//helper disk middle
translate([-14,-5,0]){ helperDisk(18); }
translate([-22,-43,0]){ helperDisk(18); }

translate([22,-43,0]){ helperDisk(18); }
translate([22,-15,0]){ helperDisk(18); }

translate([-42,-5,0]){ helperDisk(18); }
translate([-42,-40,0]){ helperDisk(18); }
}//union
