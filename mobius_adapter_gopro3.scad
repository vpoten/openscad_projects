/**
 * Mobius adapter for gopro filter adapter
 *
 */

use <dronePlates.scad>


m3Rad = 3.6/2;
goProW = 36;
goProH = 33;
mobiusOD = 18.75;// + 0.75mm 
mobiusID = 10.75;// + 0.75mm
inH = 1.5;
outH = 8;
cornerR = 4;
totalH = inH+outH;

/**
 *
 */
module adapter(){

difference(){
union(){
////translate([0,0,totalH/2]) cube(size=[goProW,goProH,totalH],center=true);
translate([0,0,0]) roundedRect([goProW-cornerR,goProH-cornerR,totalH], cornerR);
}

translate([0,0,-1]) cylinder(r=mobiusID/2,h=20,$fn=20);

translate([0,0,inH]) cylinder(r=mobiusOD/2,h=outH+1,$fn=20);

for(i=[-1,1]){ 
translate([i*(goProW/2-5),0,4]) rotate([90,0,0]) cylinder(r=m3Rad,h=goProH+1,$fn=20,center=true);
translate([0,i*(goProH/2),4]) rotate([0,90,0]) cylinder(h=goProW,r=3,$fn=30,center=true);
}

translate([0,0,totalH-2]) roundedRect([goProW-cornerR-3,goProH-cornerR-3,totalH], cornerR);

}//diff

}//end module

/**
 * simple ring for polar-pro 23mm
 */
module adapter2(){

difference(){
union(){
cylinder(r=23/2,h=totalH,$fn=30);
}
translate([0,0,-1]) cylinder(r=mobiusOD/2,h=20,$fn=20);
}//diff

}//end module


difference(){
adapter();
translate([-50,0,-1]) cube(size=100,100,20);
}


translate([50,0,0]) adapter2();

