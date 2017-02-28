/**
 * dronePlates.scad
 * Plate library
 *
 * GNU GPL V3
 * @author: Victor Potenciano
 */

m3Rad = 3.4/2;
cornerR = 4;

/**
 *
 */
module helperDisk(diameter) {
	cylinder(r = diameter/2, h = 0.6, $fn=20);
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
 * rounded rectangle triangle with corner at origin
 */
module roundedTriangle(size, radius) {
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull() {
	translate([radius, radius, 0]){ circle(r=radius); }
	translate([x-radius, radius, 0]){ circle(r=radius); }
	translate([radius, y-radius, 0]){ circle(r=radius); }
	}
}

/**
 *
 */
module roundRectPlate(w, l, plateThick=3) {
	difference(){
		roundedRect([l+m3Rad*1.75,w+m3Rad*1.75,plateThick], cornerR);
		translate([l/2, w/2, -0.5]) { cylinder(h = plateThick+1, r = m3Rad, $fn=30); }
		translate([-l/2, w/2, -0.5]) { cylinder(h = plateThick+1, r = m3Rad, $fn=30); }
		translate([l/2, -w/2, -0.5]) { cylinder(h = plateThick+1, r = m3Rad, $fn=30); }
		translate([-l/2, -w/2, -0.5]) { cylinder(h = plateThick+1, r = m3Rad, $fn=30); }
	}
}

/**
 *
 */
module crossSquarePlate(l, thick=3) {
	inDist = cornerR*2+4;
	trianL = sqrt((l*l)/2)-inDist;
	centerR = 4;

	difference(){
		roundRectPlate(l, l, thick);
		translate([0, centerR, -0.5]) { 
			rotate([0,0,45]){ roundedTriangle([trianL,trianL,thick+1], cornerR-2); }
		}
		translate([0, -centerR, -0.5]) { 
			rotate([0,0,225]){ roundedTriangle([trianL,trianL,thick+1], cornerR-2); }
		}
		translate([-centerR, 0, -0.5]) { 
			rotate([0,0,135]){ roundedTriangle([trianL,trianL,thick+1], cornerR-2); }
		}
		translate([centerR, 0, -0.5]) { 
			rotate([0,0,-45]){ roundedTriangle([trianL,trianL,thick+1], cornerR-2); }
		}
	}
}

/**
 *
 */
module hShapePlate(w, l, thick=4) {
	inDist = cornerR*2+1;

	difference(){
		roundRectPlate(w, l, thick);
		translate([0, w/4, -0.5]) { roundedRect([l-inDist,w/2-inDist,thick+1], cornerR-2); }
		translate([0, -w/4, -0.5]) { roundedRect([l-inDist,w/2-inDist,thick+1], cornerR-2); }
	}
}

/**
 *
 */
module motorCircleMount(inDia, outDia, thick=3, extraH=false, d1=19, d2=16, holeR=m3Rad ) {
	difference(){
		cylinder(h = thick, r = outDia/2, $fn=30);
		motorCircleMountHoles(inDia, outDia, thick, extraH, d1=d1, d2=d2, holeR=holeR);
	}
}

/**
 *
 */
module motorCircleMountHoles(inDia, outDia, thick=3, extraH=false, d1=19, d2=16, d3=25, holeR=m3Rad) {
	translate([0, 0, -0.5]) { cylinder(h = thick+1, r = inDia/2, $fn=30); }

	for(i=[0:3]) {
		rotate([0,0,90*i]){
		translate([d1/2, 0, -0.5]) cylinder(h = thick+1, r = holeR, $fn=20);
		translate([d2/2, 0, -0.5]) cylinder(h = thick+1, r = holeR, $fn=20);
		translate([d2/2, -holeR, -0.5]) cube(size = [(d1-d2)/2,holeR*2,thick+1]);
		}
	}
	
	if(extraH==true){	
		for(i=[-1,1]) translate([i*d3/2, 0, -0.5]) { cylinder(h = thick+1, r = holeR, $fn=30); }
	}
}

/**
 *
 */
module motorRectMount(w, l, inDia, thick=3) {
	d1=19;
	d2=16;

	difference(){
		roundRectPlate(w, l, thick);
		translate([0, 0, -0.5]) { cylinder(h = thick+1, r = inDia/2, $fn=30); }
		translate([0, d1/2, -0.5]) { cylinder(h = thick+1, r = m3Rad, $fn=30); }
		translate([0, -d1/2, -0.5]) { cylinder(h = thick+1, r = m3Rad, $fn=30); }
		translate([d2/2, 0, -0.5]) { cylinder(h = thick+1, r = m3Rad, $fn=30); }
		translate([-d2/2, 0, -0.5]) { cylinder(h = thick+1, r = m3Rad, $fn=30); }
	}
}

/**
 *
 */
module tube(inDia, outDia, height) {
	difference(){
		cylinder(h = height, r = outDia/2, $fn=50);
		translate([0, 0, -0.5]) { cylinder(h = height+1, r = inDia/2, $fn=30); }
	}
}

/**
 *
 */
module squareTube(inDia, outDia, height) {
	translate([0,0,height/2]){
	difference(){
		cube(size = [outDia,outDia,height], center = true);
		cube(size = [inDia,inDia,height+1], center = true);
	}
	}
}

/**
 *
 */
module djiFlamewheelHoles(height) {
	a = 23;
	b = 16;
	c = 19.5;
	
	translate([a/2, c/2, 0]) { cylinder(h = height, r = m3Rad, $fn=30); }
	translate([-a/2, c/2, 0]) { cylinder(h = height, r = m3Rad, $fn=30); }
	translate([b/2, -c/2, 0]) { cylinder(h = height, r = m3Rad, $fn=30); }
	translate([-b/2, -c/2, 0]) { cylinder(h = height, r = m3Rad, $fn=30); }
}

/**
 *
 */
module djiFlamewheelHolesBotton(height) {
	a1 = 21;
	c = 19.5;
	
	translate([a1/2, c/2, 0]) { cylinder(h = height, r = m3Rad, $fn=30); }
	translate([-a1/2, c/2, 0]) { cylinder(h = height, r = m3Rad, $fn=30); }
}

/**
 *
 */
module propeller(size){
union(){
difference(){
	cylinder(h = 3, r = size/2, center=true, $fn=30);
	cylinder(h = 3.1, r = size/2-2, center=true, $fn=30); 
}
for( i = [-1,1] ){
rotate([0,0,45*i]){ cube(size = [size,4,1], center = true); }
}
}
}

/**
 *
 */
module slot(length, height, rad){
for(i=[-1,1]) translate([i*length/2,0,0]) cylinder(h = height, r = rad, $fn=30);
translate([0,0,height/2]) cube(size = [length,rad*2,height], center = true);
}

 

////////////////////////
// Examples:
////////////////////////

motorCircleMount(8, 25, 3.5);

//roundedRect([50,50,3], 4);

//hShapePlate(79, 25);

//rotate([0,0,45]){roundedTriangle([40,40,3], 4);}

//crossSquarePlate(45, 4);

/*
union(){
motorRectMount(21, 18, 8, 4);
translate([9, 10.5, 0]) {tube(m3Rad*2, 6.5, 6);}
}
*/

/*
difference(){
union(){
hShapePlate(50, 30, 3.5);
translate([-4,-25,0]){cube(size = [8,50,3.5]);}
rotate([0, 0, 45]) {motorCircleMount(8, 35, 3.5);}
}
cylinder(h = 10, r = 4, $fn=100, center=true);
}
*/

//rotate([90,0,0]){ tube(5,10,20); }
//translate([20,0,0]){ squareTube(5, 10, 20); }

