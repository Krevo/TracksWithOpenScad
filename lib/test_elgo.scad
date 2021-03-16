use <elgo.scad>;

levels = 4;

end = levels-1;
for ( i = [0 : end] ) {
    translate([0, 0, (end-i)*3.2]) elgoPlateNoHole(i+1, i+1);
}
