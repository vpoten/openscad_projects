/**
 * Spool cone
 *
 */

rmax = 20;
rmin = 13;
height = 15;
rod = 6.4;
bearH = 5.2;
bearOD = 19.3;
holeR = 2;

module cone()
{
difference () {
cylinder(h = height, r1 = rmax, r2 = rmin, center = true, $fn=40);

//bearing cilinder
translate([0, 0, -height/2+(bearH+1)/2]){ cylinder(h=bearH+1.1, r = bearOD/2, center =true, $fn=30); }

//rod cilinder
cylinder(h=height*2, r = rod/2, center = true, $fn=30);

//push holes
translate([bearOD/2, 0, 0]){ cylinder(h=height*2, r = holeR, center =true, $fn=30); }
translate([-bearOD/2, 0, 0]){ cylinder(h=height*2, r = holeR, center =true, $fn=30); }
///translate([0, bearOD/2, 0]){ cylinder(h=height*2, r = holeR, center =true, $fn=30); }
///translate([0, -bearOD/2, 0]){ cylinder(h=height*2, r = holeR, center =true, $fn=30); }
}

}//module

translate([rmax+2,0,0]){ cone(); }
translate([-rmax-2,0,0]){ cone(); }
