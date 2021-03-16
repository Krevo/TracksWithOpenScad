//
// Long track, made to be compatible with Geotrax® train
// Author: Francois Crevola (francois@crevola.org)
//
use <lib/elgo.scad>;

/*
// Long track
rail_length = 152;
rail_support_length = rail_length + 0.4;
*/

// Short track
rail_length = 76;
rail_support_length = rail_length + 0.2;


support = false;
support_height = 3.2;
chanfrein = true;
rail_spacing = 29.7;

railroadTieHeight = support_height;
railroadTieLength = 48;
railroadTieWidth = 10;
railroadTieNb = round(rail_length / 30); // 5 for long track, 3 for short track

module basicRail(rail_length, rail_support_length, support_height, support=true, chanfrein=true) {

  rail_width = 4.3;
  rail_height = 4.5;
  
  if (support) {
    rotate(90, [1,0,0]) linear_extrude(height=rail_support_length, center=true) square([rail_width, support_height]);
  }

  d = 0.75; // diameter of circle for "chanfrein", try betwen 0.5 and 1
  $fn=50;
  translate([0, 0, support ? support_height : 0]) 
  rotate(90, [1,0,0]) 
  linear_extrude(height=rail_length, center=true) 
  if (chanfrein) {
    union() {
      square([rail_width, rail_height / 2]);
      minkowski()
      {
        translate([d/2, d/2, 0]) square([rail_width - d*2, rail_height - d*2]);
        translate([d/2, d/2, 0]) circle(d, $fn=100);
      }
    }
  } else {
    square([rail_width, rail_height]);
  }
}

difference() {
  union() {
    
    // Generate 2 basic rails
    translate([0, 0, !support ? support_height : 0]) // Basic rail is z=0 based thus, if asked for no rail support, we move it up (railroadTie will be the only rail support)
    for (i = [0, 1]) {
      // Make a basic rail and move it away 1/2 rail spacing away from y axis
      mirror([i, 0, 0])
      translate([rail_spacing/2, 0, 0])
      basicRail(rail_length, rail_support_length, support_height, support, chanfrein);
    }
  
    // RailroadTie
    spacing = rail_support_length/((railroadTieNb-1)*2) - railroadTieWidth;

    for (i = [-1, 1]){
      for (j = [1:railroadTieNb]) // n iterations
      {
        translate([-railroadTieLength/2,i*(j-1)*(spacing+railroadTieWidth)-railroadTieWidth/2,0])
        cube([railroadTieLength, railroadTieWidth, railroadTieHeight]);
      }
    }

    // Lego connectors
    for (i = [-1, 1]){
      translate([0, i*(rail_support_length/2 - 4), 0])
      elgoPlateNoHole(2, 1, true, false);
    }
  }
  cubeZ = 10;
  cubeX = railroadTieLength + .2;
  cubeY = railroadTieWidth;
  translate([-cubeX/2, rail_support_length/2-.1, -.1]) cube([cubeX, cubeY, cubeZ]);
  translate([-cubeX/2, -(rail_support_length/2-.1) -railroadTieWidth, -.1]) cube([cubeX, cubeY, cubeZ]);
}