epsilon = 0.0001;

// Try d = 0 for more Geotraxed version
// Try d = -7 for simplified version (more 3D-printer friendly)
// Try d = -9.0001 for extremely simplfied version (more cost friendly)

d = 0;
d = -7;
d = -(9+epsilon);

curvedTrackWithJoin();

module curvedTrackWithJoin() {

intersection () {
 translate([0,0,d]) curvedTrack();
 translate([0,0,10]) cube(size=[400,400,20], center=true);
}

translate([8,142,0]) elgoPlate();
rotate([0,0,-90]) translate([-8,142,0]) elgoPlate();

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

module curvedTrack() {

intersection() {
	// un "cube" qui permettra de couper le rail extrud.. .. un quart de cercle
	cube(size = [174, 174, 20], center = false);
	// extrusion rotative d'un profil de rail d..fini par un polygon
	rotate_extrude(convexity= 10, $fn = 100)
		translate([142,0,0])
		polygon(points=[[0,7],[-25,7],[-30,0],[-32,0],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[32,0],[30,0],[25,7]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);
}

// traverses
for (a = [5,15,25,35,45,55,65,75,85]) // n iterations
{
	rotate([0,0,a])
	translate([118, -5, 9])
	cube(size = [48, 10, 1], center = false);
}

for (a = [5,25,45,65,85]) // n iterations
{
	rotate([0,0,a])
	translate([142,0,0])
	rotate([90,0,0])
	linear_extrude(height=2.5)
		polygon(points=[[-32,0],[-25,9],[25,9],[32,0]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);
}

}