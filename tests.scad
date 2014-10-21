use <box.scad>

module cut() {
  translate([35,-70,45])
    rotate([-35,0,25]) {
      difference() {
        union() {
          children();
        }
        translate([-50,-100,0]) cube(100);
        translate([-50,0.0000000001,0]) cube(100);
      }
    }
}

if (t == 1)
  box();

if (t == 2)
  box(rad=0);

if (t == 3)
  box(rad=-5);

if (t == 4)
  box(x=10);

if (t == 5)
  translate([50,0,-50])
    rotate([10,10,0])
      box(x=60,y=60,rad=25,wall_thick=10,z2=80,print_space=30,reserve=0);

if (t == 6)
  rotate([-50,180,25])
    box(print_space=0,x=10,y=30,wall_thick=10);

if (t == 7) {
  cut() {
    translate([-19,0,0]) cylinder(r=1,h=15.5);
    box(to_print=false,reserve=0.5,z1=10,z2=5,$fn=100);
  }
}

if (t == 8)
  cut()
    box(to_print=false,reserve=0,$fn=100);

if (t == 9)
  cut()
    box(x=11,to_print=false,z1=0,z2=0,reserve=0.5,$fn=100);

if (t == 10)
  cut() {
    box(to_print=false,reserve=10,lock_z=2,$fn=100);
    translate([0,0,14]) cube([30,3,12],true);
  }

if (t == 11)
  box(x=0);

if (t == 12)
  box(x=-5);

if (t == 13)
  box(y=0);

if (t == 14)
  box(y=-5);

if (t == 15)
  box(wall_thick=0);

if (t == 16)
  box(wall_thick=-2);

// Always use "if (t == num)" including spaces!
// This file is being grepped for '^if (t == 1)' etc.
// Numbers must be in the correct order and no number can be skipped
