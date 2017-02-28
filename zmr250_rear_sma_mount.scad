/**
 * tweaker rear sms mount for antenna extension
 */
 
use <dronePlates.scad>;
use <BezierScad/BezierScad.scad>;

height=11;
tubeThick=2;
spacerDia=6.4;
diam=tubeThick*2+spacerDia;
thick=5;
adjust=5;//manual adjust of start/end curve
angle=0;




difference(){

union(){
for(i=[-1,1]){
translate([0,i*32/2,0]) tube(spacerDia, diam, height);
}

BezWall([
  [0,-32/2-diam/2+adjust],
  [14, -32/2],
  [3, 0],
  [14, 32/2],
  [0,32/2+diam/2-adjust]
  ],  
    widthCtls = [thick, 6.5, thick], 
    height = height, 
    steps = 20,
    centered = false
);

///color("pink") translate([8+6/2,0,height/2]) rotate([0,90-angle,0]) translate([0,0,-6/2]) tube(6.8,10,6);
}//end union

for(i=[-1,1]){
translate([0,i*32/2,-0.5]) cylinder(r=spacerDia/2, h=height+1, $fn=20);
}

translate([8+6/2,0,height/2]) rotate([0,90,0]) cylinder(r=6.75/2,h=6,$fn=20,center=true);

}//diff

