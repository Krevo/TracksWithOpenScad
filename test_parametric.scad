/*function parabola(f,x) = ( 1/(4*f) ) * x*x; 
module plotParabola(f,wide,steps=1) {
  function y(x) = parabola(f,x);
  module plot(x,y) {
    translate([x,y])
      circle(1,$fn=12);
  }
  xAxis=[-wide/2:steps:wide/2];
  for (x=xAxis) 
    plot(x, y(x));
}
color("red")  plotParabola(10, 100, 5);
color("blue") plotParabola(4,  60,  2);

vector1 = [[1,2,3]]; vector2 = [4]; vector3 = [[5,6]];
 new_vector = concat(vector1, vector2, vector3); // [1,2,3,4,5,6]
  
echo(new_vector);

//function quarterRailPath()

input = [2, 3, 5, 8, 10, 12];
 
// ECHO: 40
//------------------ add2 -----------------------
// An even simpler non recursive code version of add explores the 
// the matrix product operator
function add2(v) = [for(p=v) 1] *v;
*/
function courbe(v) = [for(i=[0:5:90]) [cos(i), sin(i)]];

echo(add2(input));
echo([for(p=input) p]);
echo (courbe(v));
plotPath(courbe(v));

module plot(x,y) {
    translate([x,y]) circle(0.2,$fn=12);
}
  
module plotPath(path) {
  for (e=path) {
    echo(e[0]);
    echo(e[1]);
    plot(10*e[0], 10*e[1]);
  }
}