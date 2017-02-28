/**
 * brushless gimbal suspension frame
 */

use <dronePlates.scad>


m3Rad = 3.5/2;
bobbInDia = 9.5;
bobbOutDia = 15.5;
plateThick = 2;
contrMntDist = 45;
armMount = 15;

bobbD1 = 60;
bobbD2 = 60;
hdisk=24;

difference(){
union(){

for(i=[-1,1]) for(j=[-1,1]){ 
	translate([i*bobbD1/2,j*bobbD2/2,0]){
	tube(bobbInDia,bobbOutDia,plateThick);
	tube(bobbOutDia,bobbOutDia+4,plateThick+1);
	}//

	translate([i*contrMntDist/2,j*contrMntDist/2,0]) tube(m3Rad*2,7,plateThick+4);

	hull(){
		translate([i*bobbD1/2,j*bobbD2/2,0]) cylinder(r=bobbInDia/2+1,h=plateThick+1,$fn=30);
		translate([i*contrMntDist/2,j*contrMntDist/2,0]) cylinder(r=bobbInDia/2+0.5,h=plateThick+1,$fn=30);
	}
}

crossSquarePlate(contrMntDist, thick=plateThick+1);

cylinder(r=armMount/2+4,h=plateThick+1,$fn=30);

}//union

for(i=[-1,1]) for(j=[-1,1]){
	translate([i*bobbD1/2,j*bobbD2/2,plateThick]) cylinder(r=bobbOutDia/2,h=plateThick+5,$fn=30);
	translate([i*bobbD1/2,j*bobbD2/2,0]) cylinder(r=bobbInDia/2,h=plateThick+5,$fn=30,center=true);
	translate([i*contrMntDist/2,j*contrMntDist/2,0]) cylinder(r=m3Rad,h=plateThick+5,$fn=30,center=true);
}

for(i=[0:3]) //arm mount holes
rotate([0,0,i*90]) translate([armMount/2,0,0]) cylinder(r=m3Rad,h=plateThick+5,$fn=30,center=true);

}//diff

for(i=[-1,1]) for(j=[-1,1]){ 
	translate([i*(bobbD1+hdisk)/2,j*(bobbD2+hdisk)/2,0]) helperDisk(hdisk);
}



