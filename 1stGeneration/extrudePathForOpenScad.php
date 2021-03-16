<?php

// François CREVOLA
// 2014-07-16
// License BSD

// Generate a file for OpenScad
// (run this script and redirect the output to a .scad file)

$points = [[0,7],[-25,7],[-30,0],[-32,0],[-25,9],[-19,9],[-19,13],[-15,13],[-15,9],[15,9],[15,13],[19,13],[19,9],[25,9],[32,0],[30,0],[25,7]];
$points = points2DTo3D($points);

$sliceTabPts = [[400,100],[341.1556782041163,97.68800029984595],[282.67415121982685,90.76625544635328],[224.915977108071,79.27744029825737],[168.23725421878945,63.292387221365175],[112.98742572618272,42.90964938346508],[59.507125195339995,18.25489314127583],[8.126076463038487,-10.519876734430909],[-40.83893921935476,-43.23725421878942],[-59.16106078064513,-56.76274578121058],[-108.12607646303837,-89.48012326556909],[-159.50712519533994,-118.25489314127583],[-212.98742572618266,-142.90964938346508],[-268.2372542187894,-163.29238722136517],[-324.91597710807093,-179.27744029825737],[-382.67415121982685,-190.76625544635328],[-441.15567820411627,-197.68800029984595],[-500,-200]];

// start and end point
$tmin=0;
$tmax=count($sliceTabPts)-1;
// number of steps along path
$tstep=$tmax;

// path to extrude along
function path($t) {
  global $sliceTabPts;
  return [$sliceTabPts[$t][0],$sliceTabPts[$t][1],0];
}

echo "//".PHP_EOL;
echo "//  'S-Track' ".PHP_EOL;
echo "// /!\ WORK IN PROGRESS ".PHP_EOL;
echo "//".PHP_EOL;

$arrPoints = extrude_path($tmin,$tmax,$tstep,$points,'path');

function extrude_path($tmin,$tmax,$tstep,$points,$pathFunction) {

	$dt = ($tmax-$tmin)/$tstep;
	for($t = $tmin; $t<=$tmax-$dt; $t+=$dt) {

		$at = 0; // WORK IN PROGRESS : we need a small rotation around z-axis => a1($t,$dt,$pathFunction); echo "angle rot Z ".$at.PHP_EOL;
		$adt = 0; //WORK IN PROGRESS : we need a small rotation around z-axis =>  a1($t+$dt,$dt,$pathFunction); echo "angle rot dt Z ".$adt.PHP_EOL;
		$points1 = rotatePoints(translatePoints(rotatePoints($points,[-90,0,90]),$pathFunction($t)),[0,0,$at]);
		$points2 = rotatePoints(translatePoints(rotatePoints($points,[-90,0,90]),$pathFunction($t+$dt)),[0,0,$adt]);
				
		$pointsM = array_merge($points1,$points2);
		
		echo "polyhedron(points = [";
		for($i = 0; $i < count($pointsM); $i++) {
		    list($x,$y,$z) = $pointsM[$i];
			echo "[$x, $y, $z]".(($i == count($pointsM)-1)?"":", ");
		}
		echo "], triangles = [";
		// Face with all points from $points1
		echo "[";
		for($i = 0; $i < count($points1); $i++) {
			echo "$i".(($i == count($points1)-1)?"":", ");
		}
		echo "], [";
		// Face with all points from $points2 (reversed, because we want them to be in clockwise order)
		for($i = count($pointsM)-1; $i >= count($points1); $i--) {
			echo "$i".(($i == count($points1))?"":", ");
		}
		echo "],";
		// + All triangular face between $points1 and points2
		for($i = 0; $i < count($points1); $i++) {
		  $N = count($points1);
		  $j = $i + 1;
		  if ($j == count($points1)) {
			$j = 0;
		  }
		   echo "[".($i).",".($i+$N).",".$j."],[".($j).",".($i+$N).",".($j+$N)."]".(($i == count($points1)-1)?"":", ");
		}
		echo "]);".PHP_EOL;
	}
}

function translatePoints($points,$translationVector) {
  list($tx,$ty,$tz) = $translationVector;
  $points = points2DTo3D($points); // make sure, points are 3D, ie [x,y,z]
  foreach ($points as $pt) {
    list($x,$y,$z) = $pt;
  	$returnedPts[] = [$x+$tx, $y+$ty, $z+$tz];
  }
  return $returnedPts;
}

function points2DTo3D($points) {
  foreach ($points as $pt) {
  	if (count($pt)==2) {
  	  $pt[] = 0; // If missing, add a third coordinate: z = 0
	  }
  	$returnedPts[] = $pt;
  }
  return $returnedPts;
}

function rotatePoints($points,$rotateVector) {
  list($rx,$ry,$rz) = $rotateVector;
  $points = points2DTo3D($points); // make sure, points are 3D, ie [x,y,z]
  foreach ($points as $pt) {
  	$returnedPts[] = rotateZ(rotateY(rotateX($pt,$rx),$ry),$rz);
  }
  return $returnedPts;
}

function rotateX($pt,$angle) {
  if ($angle == 0) {
    return $pt; // unchanged
  }
  $a = deg2rad($angle) ;
  list($x,$y,$z) = $pt;
  return [$x, $y*cos($a)+$z*sin($a), -$y*sin($a)+$z*cos($a)];
}

function rotateY($pt,$angle) {
  if ($angle == 0) {
    return $pt; // unchanged
  }
  $a = deg2rad($angle) ;
  list($x,$y,$z) = $pt;
  return [$x*cos($a)-$z*sin($a), $y, $x*sin($a)+$z*cos($a)];
}

function rotateZ($pt,$angle) {
  if ($angle == 0) {
    return $pt; // unchanged
  }
  $a = deg2rad($angle) ;
  list($x,$y,$z) = $pt;
  return [$x*cos($a)+$y*sin($a), -$x*sin($a)+$y*cos($a), $z];
}

// angle between x-axis and projection of dx(t) onto the xy-plane
function a1($t,$dt,$pathFunction) {
  list($xt,$yt,$zt) = $pathFunction($t);
  list($xdt,$ydt,$zdt) = $pathFunction($t+$dt);
  return rad2deg(atan2($ydt-$yt,$xdt-$xt));
}

