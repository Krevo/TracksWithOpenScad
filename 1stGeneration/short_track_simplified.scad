//
// Short track, made to be compatible with Geotrax®
// (Work in progress : no join system between tracks)
// Author: Francois Crevola (francois@crevola.org)
//

// Try d = 0 for more Geotraxed version
// Try d = -7 for simplified version (more 3D-printer friendly)
d = -7;

intersection() {
	translate([0,0,d]) shortTrack();
	translate([0,0,10]) cube(size=[150,150,20], center=true);
}

module shortTrack() {

	long = 76.5;

	// main piece
		rotate([90,0,0])
		translate([0, 0, -long/2]) // center
		linear_extrude(height=long)
			polygon(points=[[0,7],[-25,7],[-30,0],[-32,0],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[32,0],[30,0],[25,7]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);


	// + traverses
	spacing = 18;
	max = 4;
	delta = 6;
	for (i = [1:max]) // n iterations
	{
		translate([0,-long/2+(i*spacing)-delta,9])
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