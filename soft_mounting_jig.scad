use <dronePlates.scad>;

m3Rad = 3.4/2;
m4Rad = 4.4/2;
diameter = 25;
thick = 1.5;
height = thick*2 + 1.5;

module motorHoles(){
    motorCircleMountHoles(8, diameter, thick=thick, d1=19, d2=19, holeR=m4Rad);
    motorCircleMountHoles(8, diameter, thick=thick, d1=16, d2=16, holeR=m4Rad);
}

difference(){
    cylinder(r=diameter/2, h=thick, $fn=30);
    motorHoles();
}

translate([30,0,0]){
difference(){
    union(){
        cylinder(r=(diameter+5)/2, h=height, $fn=30);
        for(i=[-1,1]){
            translate([0,i*(diameter+2.5)/2, (height+1)/2]){
                cube(size=[1.5,2.5,height+1], center=true);
            }
        }
    }
    
    translate([0,0,thick]){
        cylinder(r=diameter/2, h=height - 1.5 +0.1, $fn=30);
    }
    motorHoles();
}
}