use <dronePlates.scad>


m3Rad = 3.5/2;


difference(){

hull(){
motorCircleMountHoles(8, 21, thick=1.5, extraH=false, d1=19, d2=16, d3=25, holeR=3.1);
}

motorCircleMountHoles(8.2, 21, thick=1.5, extraH=false, d1=19, d2=16, d3=25, holeR=m3Rad);

}
