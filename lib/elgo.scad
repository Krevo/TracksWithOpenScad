module elgoPlateNoHole(nbPlotInXDir, nbPlotInYDir, center=false, removeScrape=true) {

    plotHeight = 1.7;
    plotRadius = 2.4;
    baseHeight = 3.2;
    e = 0.1; // epsilon, to make a more than zero contact between cylinder and cube
    
    tremove = removeScrape ? 0.1 : 0;
    tx = center ? -8*nbPlotInXDir/2 : 0;
    ty = center ? -8*nbPlotInYDir/2 : 0;
    
    translate([tx, ty, 0]) {
        // We need a little space between two plates ! Real Lego remove 0.1mm around, otherwise 2 consecutives plates will "scrape". 
        union() {
            translate([tremove, tremove, 0]) cube(size=[nbPlotInXDir*8-tremove*2, nbPlotInYDir*8-tremove*2, baseHeight], center=false);
            for(i=[0 :  nbPlotInXDir-1]) {
                for(j=[0 : nbPlotInYDir-1]) {
                    translate([4+i*8, 4+j*8, baseHeight - e]) cylinder(h=plotHeight + e, r=plotRadius, $fn=100);
                }
            }
        }
    }

}