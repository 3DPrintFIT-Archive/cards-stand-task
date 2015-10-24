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
    cut() cardholder(cards=-10, delta=2, spacing=5); // negative delta
}

if (t == 4) {
    cut() cardholder(cards=10, delta=0, spacing=5); // 0 delta
}

if (t == 5) {
    distance(1.2) cardholder(spacing=10); // big spacing
}

if (t == 6) {
    distance() {
        cardholder(thickeness=0.01, thickness=0.01, $fn=100); // small thickness
    }
}

if (t == 7) {
    distance() cardholder(visibility=1, spacing=0); // front holder should still exist, just with thickness
}

if (t == 8) {
    distance() {
        // should be equal
        cardholder(visibility=1);
        translate([-100,0,0]) cardholder(visibility=100);
    }
}

if (t == 9) {
    distance() {
        // should be equal
        cardholder(visibility=0, cards=2);
        translate([-100,0,0]) cardholder(visibility=-100, cards=2);
    }
}

if (t == 10) {
    distance() {
        // should be equal
        $fn=30;
        scale(100)
            cardholder(size=[85, 54, 1]/100, thickness=0.03, thickeness=0.03, spacing=0.01, delta=0.25, cards=3);
        translate([-100,0,0])
            scale(0.01)
                cardholder(size=[85, 54, 1]*100, thickness=300, thickeness=300, spacing=100, delta=2500, cards=3);
    }
}

if (t == 11) {
    distance() {
        // should line up
        translate([0,0,85/2]) cardholder(visibility=1);
        translate([-30,0,0]) cardholder(visibility=0.5);
    }
}

// Always use "if (t == num)" including spaces!
// This file is being grepped for '^if (t == 1)' etc.
// Numbers must be in the correct order and no number can be skipped
