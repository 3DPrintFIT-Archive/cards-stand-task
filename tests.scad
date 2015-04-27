use <box.scad>

module cut() {
  translate([35,-70,45])
    rotate([-35,0,25]) {
      difference() {
        union() {
          children();
        }
        translate([-500,-1000,-100]) cube(1000);
        translate([-500,0.0000000001,-100]) cube(1000);
      }
    }
}

if (t == 1)
  box(); // default arguments

if (t == 2)
  box(rad=0); // should be rectangular inside, but rounded outside

if (t == 3)
  box(rad=-5); // same as rad=0

if (t == 4)
  box(x=10); // rad has to be lowered

if (t == 5)
  translate([50,0,-50])
    rotate([10,10,0])
      box(x=60,y=60,rad=25,wall_thick=10,z2=80,print_space=30,reserve=0); // random shit, that fits into the pic

if (t == 6)
  rotate([-50,180,25])
box(print_space=0,x=10,y=30,wall_thick=10); // the part touch each other

if (t == 7) {
  cut() {
    translate([-19,0,0]) cylinder(r=1,h=15.5);
    box(to_print=false,reserve=0.5,z1=10,z2=5,$fn=100); // chek of height with reserve and that both teeth are the same size
  }
}

if (t == 8)
  cut()
    box(to_print=false,reserve=0,$fn=100); // no reserve = cannot see the gap

if (t == 9)
  cut()
    box(x=11,to_print=false,z1=0,z2=0,reserve=0.5,$fn=100); // box height has to be adapted to teeth and reserve

if (t == 10)
  cut() {
    box(to_print=false,reserve=10,lock_z=2,$fn=100); // no teeth, but gap of the size of lock_z+reserve
    translate([0,0,14]) cube([30,3,12],true);
  }

if (t == 11) {
  box(x=0); // nothing
  box(x=-5); // nothing
  box(y=0); // nothing
  box(y=-5); // nothing
  box(wall_thick=0); // nothing
  box(wall_thick=-2); // nothing
}

if (t == 12) {
  // A complicated test case
  // We want a box without teeh, without walls, 2.5 mm distance between base and ceiling, because reserve > wall_thick
	translate([-5,0,5])
 	cut() {
    	box(x=5,y=5,z1=1,z2=1,lock_z=1,wall_thick=1,to_print=false);
	    translate([4,0,0]) cube([5,5,1+1+2.5]);
  	}
}

if (t == 13) {
  // Normal test with little weird values
	scale([0.45,0.45,0.45])
	    rotate([10,0,20])
		    box(x=15,y=35,z1=14,z2=12,lock_z=15,wall_thick=14);
}

if (t == 14) {
  // Normal test with little weird values and no reserve
	scale(0.7)
	    rotate([0,0,170])
		    box(x=35,y=35,z1=14,z2=12,lock_z=1,wall_thick=4,reserve=0);
}

if (t == 15) {
  // Check the height is 25 mm and the pylon is form side to side
	scale(0.5){
		cut(){
			box(x=35,y=35,z1=25,z2=20,lock_z=5,wall_thick=4,reserve=0);
			cube (size=[5,5,20],center=true);
		}
	}
}

if (t == 16) {
	// z1 and z2 as 0
	cut(){	
		scale(1.5){
			box(x=30, y=10, z1=0, z2=0, rad=0, wall_thick=1, lock_z=0, reserve=1, to_print=false);
		}
	}
}

if (t == 17) {
	// Use little numbers
	cut(){
		scale(2.5) translate([0,0,-5]) box(x=10,y=10,wall_thick=0.2,reserve=0.2/3, to_print=false,$fn=100);
	}
}

if (t == 18) {
	// Parts should be placed on top of each other
	cut(){
		box(x=10,y=10,z1=12,z2=10,reserve=2/3,print_space=-14);
	}
}

if (t == 19) {
    scale(0.1)
        box(x=300, y=300, z1=100, z2=50, rad=150, wall_thick=20, lock_z=20, reserve=15, to_print=true, print_space=50);
}

// Always use "if (t == num)" including spaces!
// This file is being grepped for '^if (t == 1)' etc.
// Numbers must be in the correct order and no number can be skipped
