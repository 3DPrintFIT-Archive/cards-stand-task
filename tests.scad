use <box.scad>


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

// Always use ""if (t == num)" including spaces!
