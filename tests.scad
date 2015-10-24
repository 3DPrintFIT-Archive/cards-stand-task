use <cardholder.scad>

// Helping modules

module distance(factor=1) {
    translate([-100,230,-250]*factor) rotate([0,0,-30]) children();
}

module cut(factor=1) {
    rotate([0,-55+90,25+90]) translate([300*factor,0,-65]) {
        difference() {
            children();
            translate([-10000,-5000,0]) cube(10000);
        }
    }
}

// Tests

if (t == 1) {
    distance() cardholder(); // default arguments
}

if (t == 2) {
    cut() cardholder(cards=10, delta=2, spacing=5); // almost default arguments from inside
}

if (t == 3) {
    cut() cardholder(cards=10, delta=0, spacing=5); // 0 delta
}

// Always use "if (t == num)" including spaces!
// This file is being grepped for '^if (t == 1)' etc.
// Numbers must be in the correct order and no number can be skipped
