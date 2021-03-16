// Pyramid of lego plates
use <elgo.scad>;

levels = 4;

end = levels-1;
for ( i = [0 : end] ) {
    translate([0, 0, (end-i)*3.2]) elgoPlateNoHole(2*i+1, 2*i+1, true);
}