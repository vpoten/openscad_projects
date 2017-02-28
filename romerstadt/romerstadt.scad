/**
 *
 */
use <../dronePlates.scad>

union(){

scale([2,2,2]){
translate([-10,-50,0]){
import (file = "romerstadt1.stl");
}
}

translate([-19,91,0]){ helperDisk(18);}
translate([0,93,0]){ helperDisk(18);}

translate([-13,-93,0]){ helperDisk(18);}
translate([6,-95,0]){ helperDisk(18);}

translate([17,-38,0]){ helperDisk(18);}

}
