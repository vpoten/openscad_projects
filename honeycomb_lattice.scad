/**
 * Honeycomb lattice library
 *
 * @autor: vpoten
 */
 
/**
 *
 */
module hexagon(rad, cornerR, thick) {
hull(){
	for(i=[0:5]){
	rotate([0,0,60*i]) translate([rad,0,0]) cylinder(r=cornerR, h=thick, $fn=20);
	}
}
}//end module hexagon

/**
 * @param rows:  number of rowns, must be greater than 0
 * @param cols:  number of colummns, must be greater than 1
 */
module honeycombLattice(rows, cols, hexaR, cornerR, thick, innerDst, fillHalves=false) {

extHexR = sqrt(2*cornerR*cornerR) + hexaR + innerDst/2;
extHexSideL = sin(30)*extHexR*2;
extHexH = cos(30)*extHexR;
dist = 2*extHexR + extHexSideL;
hexH = sqrt(2*cornerR*cornerR) + hexaR;

numEvenCols = floor(cols/2)+(cols%2);
numOddCols = floor(cols/2);

translate([extHexR,extHexH,0]) {
for(i=[0:rows-1]){
	if((i%2)==1){
		for(j=[0:numOddCols-1]) translate([dist*j+(extHexR+extHexSideL/2),i*extHexH,0]) hexagon(hexaR, cornerR, thick);
	}
	else{
		for(j=[0:numEvenCols-1]) translate([dist*j,i*extHexH,0]) hexagon(hexaR, cornerR, thick);
	}
}

if( fillHalves==true ){

	for(i=[-1,rows]){ 
		for(j=[0:numOddCols-1]) translate([dist*j+(extHexR+extHexSideL/2),i*extHexH,0]){
			difference(){
			hexagon(hexaR, cornerR, thick);
			if(i==-1){ translate([0,-extHexR/2+innerDst/2,0]) cube(size=[extHexR*2,extHexR,thick*2.5],center=true); }
			else{ translate([0,extHexR/2-innerDst/2,0]) cube(size=[extHexR*2,extHexR,thick*2.5],center=true); }
			}
		}
	}
}

}//translate

}//end module honeycombLattice

//test
hexagon(20, 2, 29);
honeycombLattice(2, 4, 15, 3, 3, 11, fillHalves=false);
color("grey") translate([0,0,40]) honeycombLattice(5, 6, 11, 2, 3, 19, fillHalves=true);
color("blue") translate([0,0,60]) honeycombLattice(3, 5, 5, 2, bottomThick+1, 3, fillHalves=true);
