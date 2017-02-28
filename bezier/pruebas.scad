use <BezierScad.scad>;

/**
 *
 */
module shape() {
x = 50;
y = 80;
BezLine([
  [0,y], [x,y], [x,y-45], [x,y],[0,-10],[x,-y-10], [x,-y-10], [0,-y-10]
  ], width = [2.5, 2.5], resolution = 4, centered = true, showCtls = true);
}// end module

module cone1(){
difference(){
rotate_extrude(convexity = 10)
{
shape();
}
translate([-x/3,0,0]){
cube([x/1.5,x+15,x*5], center=true);
}

for(j=[-3:0])
for(i=[0:6]){
	rotate([0,0,i*60+30]){ translate([0,x/2,j*25]){
rotate([90,0,0]){cylinder(h = 30, r=10, center=true);}} 
}
}
}
}

module plate(){
rotate([90,0,90])
hull(){
shape();
mirror() shape();
}
}

module plate2(){
difference(){
plate();
scale([1,0.8,0.8]){plate();}
}
}

shape();
//plate2();
//color("Red"){ cone1(); }



