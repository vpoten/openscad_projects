/**
 * lt210 fpv camera mount
 */
 
use <dronePlates.scad>;

thick = 1.5;
holeDst = 30.5;
m3Rad = 3.4/2;

difference(){
    union(){
        for(i=[-1,1]){
            hull(){
                for(j=[-1,1]){
                    translate([i*holeDst/2, j*holeDst/2, 0])
                    cylinder(r=m3Rad*2, h=thick, $fn=30);
                }
            }
        }
        hull(){
        for(i=[-1,1]){
            for(j=[0,1]){
                translate([i*holeDst/2, j*holeDst/2, 0])
                cylinder(r=m3Rad*2, h=thick, $fn=30);
            }
        }
        }
    }

for(i=[-1,1]){
    for(j=[-1,1]){
        translate([i*holeDst/2, j*holeDst/2, -0.5])
        cylinder(r=m3Rad, h=thick+1, $fn=30);
    }
}

translate([0,-15,-0.5]) {
    roundedRect([20,30,thick+1], 4);
}
}
