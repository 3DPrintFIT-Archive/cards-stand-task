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
  box(); // výchozí parametry

if (t == 2)
  box(rad=0); // hranatá zevnitř, kulatá zvenku

if (t == 3)
  box(rad=-5); // stejná jako pro rad=0

if (t == 4)
  box(x=10); // rad se musí vhodně zmenšit

if (t == 5)
  translate([50,0,-50])
    rotate([10,10,0])
      box(x=60,y=60,rad=25,wall_thick=10,z2=80,print_space=30,reserve=0); // random shit, co se vleze do obrázku

if (t == 6)
  rotate([-50,180,25])
box(print_space=0,x=10,y=30,wall_thick=10); // dílky jsou na dotek od sebe, bez mezery

if (t == 7) {
  cut() {
    translate([-19,0,0]) cylinder(r=1,h=15.5);
    box(to_print=false,reserve=0.5,z1=10,z2=5,$fn=100); // kontrola výšky s rezervou a stejné šíře zubů
  }
}

if (t == 8)
  cut()
    box(to_print=false,reserve=0,$fn=100); // žádná rezerva = žádná díra není vidět

if (t == 9)
  cut()
    box(x=11,to_print=false,z1=0,z2=0,reserve=0.5,$fn=100); // výška krabičky se musí přizpůsobit zubům a reservě

if (t == 10)
  cut() {
    box(to_print=false,reserve=10,lock_z=2,$fn=100); // žádné zuby, ale odskok o lock_z+reserve
    translate([0,0,14]) cube([30,3,12],true);
  }

if (t == 11) {
  box(x=0); // nic
  box(x=-5); // nic
  box(y=0); // nic    
  box(y=-5); // nic
  box(wall_thick=0); // nic
  box(wall_thick=-2); // nic
}

if (t == 12) {
  // Test, ktery je zameren na pomerne slozity test case
  // Ocekavam karabičku bez zubů a bez stěn 2,5 mm od sebe dno a strop, protože reserve > wall_thick
	translate([-5,0,5])
 	cut() {
    	box(x=5,y=5,z1=1,z2=1,lock_z=1,wall_thick=1,to_print=false);
	    translate([4,0,0]) cube([5,5,1+1+2.5]);
  	}
}

if (t == 13) {
  // Normalni test s mirne divnyma hodnotama
	scale([0.45,0.45,0.45])
	    rotate([10,0,20])
		    box(x=15,y=35,z1=14,z2=12,lock_z=15,wall_thick=14);
}

if (t == 14) {
  // Normalni test s mirne divnyma hodnotama, rezerva je 0
	scale(0.7)
	    rotate([0,0,170])
		    box(x=35,y=35,z1=14,z2=12,lock_z=1,wall_thick=4,reserve=0);
}

if (t == 15) {
  // Kontrola rozmeru vyska je 25 mm a mezi dily je presne pylon od kraje ke kraji
	scale(0.5){	
		cut(){
			box(x=35,y=35,z1=25,z2=20,lock_z=5,wall_thick=4,reserve=0);
			translate([0,0,25/2])cube (size=[5,5,25],center=true);
		}
	}
}

// Always use "if (t == num)" including spaces!
// This file is being grepped for '^if (t == 1)' etc.
// Numbers must be in the correct order and no number can be skipped
