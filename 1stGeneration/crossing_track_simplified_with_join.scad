//
// Crossing track, made to be compatible with Geotrax®
// (Work in progress : no join system between tracks)
// Author: Francois Crevola (francois@crevola.org)
//

epsilon = 0.0001;

// Try d = 0 for more Geotraxed version
// Try d = -7 for simplified version (more 3D-printer friendly)
// Try d = -9.0001 for extremely simplfied version (more cost friendly)

//d = 0;
//d = -7;
d = -(9+epsilon);

/*
intersection() {
  translate([0,0,10]) cube(size=[150,150,20],center=true);
  translate([0,0,d]) crossingTrack();
}
*/

crossingTrack();

module crossingTrack() {
  difference() {
    union() {
      rotate([0,0,0])	  longTrackWithJoin();
      rotate([0,0,90]) longTrackWithJoin();
    }

    for (i = [0,90,180,270]) {
	  rotate([0,0,i]) translate([0, 11, 12+d]) cube(size = [40,8,4], center = true);
    }
  }
}

module longTrackWithJoin() {

intersection() {
  translate([0,0,d]) longTrack();
  translate([0,0,10]) cube(size=[150,150,20], center=true);
}

translate([0,153/2-10,0]) elgoPlate();
translate([0,-153/2+10,0]) elgoPlate();

}

module elgoPlate() {
   for(i=[-1,1]) {
		for(j=[-1,1]) {
			translate([i*4,j*4,0]) elgoPlot();
		}
	}
}

module elgoPlot() {
	translate([0,0,2]) cylinder(h = 2, r=2.5, $fs=0.5);
	translate([0,0,1]) cube(size=[8,8,2], center=true);
}

module longTrack() {

long = 153;

// main piece
	rotate([90,0,0])
	translate([0, 0, -long/2]) // center
	linear_extrude(height=long)
		polygon(points=[[0,7],[-25,7],[-30,0],[-32,0],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[32,0],[30,0],[25,7]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);


// + traverses
spacing = 22;
max = 7;
delta = 10;
for (i = [1:max]) // n iterations
{
	translate([0,-long/2+(i*spacing)-delta,9.5])
	cube(size = [48, 10, 1], center = true);
}

// + supports
for (i = [-1, 0, 1]) {
	translate([0,i*(long/3),0])
	rotate([90,0,0])
	linear_extrude(height=2.5)
		polygon(points=[[-32,0],[-25,9],[25,9],[32,0]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);
}

}