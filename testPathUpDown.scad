
// A Path is a list of points
path = [[-3, -1, 0], [-2, -1, 0], [-1, -1, 0], [0, 0, 0], [1, 1, 0], [2, 1, 0], [3, 1,0]];

// Give upper path (path translate upward by a given value
function pathUp(path, val) = [for(point = path) [point[0], point[1] + val, point[2]]]; 

// Give lower path (path translate downward by a given value
function pathDown(path, val) = [for(point = path) [point[0], point[1]-val, point[2]]]; 

echo(pathCenter);

u = [0, 1, 0];
v = [1, 0, 1];

for(point = path) {
    echo(point);
    translate(point) color([1,0,0]) cube([0.2,0.2,0.2], center=true);
}

for(point = pathUp(path, 1)) {
    echo(point);
    translate(point) color([0,1,0]) cube([0.2,0.2,0.2], center=true);
}

for(point = pathDown(path, 1)) {
    echo(point);
    translate(point) color([0,0,1]) cube([0.2,0.2,0.2], center=true);
}

B = [-3, -1, 0];
A = [-1, -1, 0];
C = [1, 1, 0];

// AB = [(xB - xA), (yB - yA), (zB - zA)]
AB = [B[0] - A[0], B[1] - A[1], B[2] - A[2]];

// AC = [(xC - xA), (yC - yA), (zC - zA)]
AC = [C[0] - A[0], C[1] - A[1], C[2] - A[2]];

echo(AB);
echo(AC);
echo(norm(AB));
echo(norm(AC));
echo(AB*AC);

// AB.AC=|AB|*|AC|*cos(BAC)
angle=acos( AB*AC / (norm(AB)*norm(AC)));
echo(angle);

// Give angle between segments [AB] and [AC] (on x/y plan)
function angle(A, B, C) = 
  let(BA = [A[0] - B[0], A[1] - B[1], A[2] - B[2]],
      BC = [C[0] - B[0], C[1] - B[1], C[2] - B[2]]) 
      acos( BA*BC / ( norm(BA) * norm(BC) ) );

// Give real angle (can be > 180°) , with yDir (up = 1, down = -1) 
function angleReal(A, B, C, yDir) = 
  let(BPrime = [B[0], B[1] + yDir, B[2]]) 
      angle(A, B, BPrime) + angle(BPrime, B, C);

function rotationAFaire(A, B, C, yDir) =
	let (BPrime = [B[0], B[1] + yDir, B[2]],
        targetAngle = angleReal(A, B, C, yDir) / 2,
		  currentAngle = angle(A, B, BPrime))
		(currentAngle - targetAngle)*(yDir/abs(yDir));

A = [-3, -1, 0];
BPrime = [-1, 0, 0];
Bt = [-1, 2, 0];
BSecondPrime = [-1, 0, 0];
B = [-1, -1, 0];
C = [1, 1, 0];
CPrime = [1, 2, 0];
CSecond = [1, -1, 0];
D = [2 ,1, 0];

echo("----");
echo(angle(A, B, BPrime));
echo(angle(BPrime, B, C));
echo(angleReal(A, B, C, 1));
echo(angleReal(A, B, C, -1));
echo("----");
echo(angle(B, C, CPrime));
echo(angle(CPrime, C, D));
echo(str(angle(B, C, D)," / ",angleReal(B, C, D, 1)));
echo(str(angle(B, C, D)," / ",angleReal(B, C, D, -1)));
echo("----");
echo(rotationAFaire(A, B, C, 1));
echo(rotationAFaire(A, B, C, -1));
echo("----");
echo(rotationAFaire(B, C, D, 1));
echo(angle(B, C, CSecond));
echo(rotationAFaire(B, C, D, -1));
echo("----");
echo(rotationAFaire(Bt, C, D, 1));
echo(rotationAFaire(Bt, C, D, -1));

echo("-*-*-*-");
E = [1, 1, 0];
F = [1, 2, 0];
G = [1, 3, 0];
echo(rotationAFaire(E, F, G, 1));
echo(rotationAFaire(E, F, G, -1));
H = [2, 4, 0];
echo(rotationAFaire(F, G, H,1));
echo(rotationAFaire(F, G, H, -1));
I = [0, 4, 0];
echo(rotationAFaire(F, G, I,1));
echo(rotationAFaire(F, G, I, -1));

//path = [[-3, -1, 0], [-2, -1, 0], [-1, -1, 0], [0, 0, 0], [1, 1, 0], [2, 1, 0], [3, 1,0]];

// Give upper path (path translate upward by a given value
function pathUp(path, val) = [for(point = path) [point[0], point[1] + val, point[2]]]; 

// Give lower path (path translate downward by a given value
function pathDown(path, val) = [for(point = path) [point[0], point[1]-val, point[2]]]; 


// Build a vector, by putting first element, element that have a predecessor and successor, last element
// Then, will examine, angles between segment defined by these points ...
// First point : theorical angle with previous and next segment is 180°
// Last point : theorical angle with previous and next segment is 180°
// Other point : calculate angle(prevPoint, Point, nextPoint)
function pathPt(path) = [path[0], for(i = [1 : len(path)-2]) path[i], path[len(path)-1]];

function pathPtRotationAFaire(path, dir) = [-1 /* A Determiner*/, for(i = [1 : len(path)-2]) rotationAFaire(path[i-1], path[i], path[i+1], dir), -1 /* A Determiner*/];

echo(len(path)-1);
echo(path[0]);
echo(path[6]);
echo(pathPt(path));
echo(pathPtRotationAFaire(path,1));
//echo(angle(A, B, C));
//echo(angle(C, B, A));
