intersection() {
	// un "cube" qui permettra de couper le rail extrud.. .. un quart de cercle
	cube(size = [174, 174, 20], center = false);
	// extrusion rotative d'un profil de rail d..fini par un polygon
   translate([0,0,-7])
	rotate_extrude(convexity= 10, $fn = 100)
		translate([142,0,0])

//		polygon(points=[[0,7],[-25,7],[-30,0],[-32,0],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[32,0],[30,0],[25,7]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);

		polygon(points=[[0,7],[-25,7],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[25,7]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);

}

// traverses
for (a = [5,15,25,35,45,55,65,75,85]) // n iterations
{
	rotate([0,0,a])
	translate([118, -5, 2])
	cube(size = [48, 10, 1], center = false);
}

/*
for (a = [5,25,45,65,85]) // n iterations
{
	rotate([0,0,a])
	translate([142,0,0])
	rotate([90,0,0])
	linear_extrude(height=2.5)
		polygon(points=[[-32,0],[-25,9],[25,9],[32,0]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);
}
*/

/*
		polygon(points=[[0,7],[-25,7],[-30,0],[-32,0],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[32,0],[30,0],[25,7]], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]);
*/