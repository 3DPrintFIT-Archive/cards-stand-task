// most important module, basic building block
module block(x, y, z, radius) {
    // by doing it in 2D and extruding it, we save time and CPU
    linear_extrude(height=z) {
        // by using hull and 2-dimensional for, we could omit this if/else statement for the sake of speed
        if ((y-2*radius) > 0) {
            offset(r=radius)
                square(size=[x-2*radius, y-2*radius], center=true);
        } else {
            // because we cannot make square with size [*,0]
            square(size=[x-2*radius, y], center=true);
            for(i=[-1,1])
                translate([i*(x/2-radius),0])
                    circle(r=radius);
        }
    }
}

module cardholder(size=[85, 54, 1],
                  thickness=3,
                  spacing=1,
                  cards=4,
                  delta=25,
                  visibility=0.3) {
    // make sure we have something to render
    if(cards >= 1 && (len(size) == 2 || len(size) == 3) && size[0] > 0 && size[1] > 0) {
        // sanity the inputs
        size = (len(size) < 3) ? [size[0], size[1], 0] : size;
        spacing = max(spacing,0);
        thickness = max(thickness,0);
        visibility = max(min(visibility,1),0);
        rot=(delta < 0) ? 180 : 0;
        delta = abs(delta);
        extra=size[2]+2*spacing+thickness; // extra size for each card except first (first is extra + thickness)
        rotate([0, 0, rot]) {
            difference() {
                // base block
                for(c=[0:(cards-1)]) {
                    translate([0,c*extra/2,0]) // translate it to "the end"
                        block(size[1]+2*spacing+2*thickness, // always the same
                              (cards-c)*extra+thickness, // the higher the card num is, add less extra
                              thickness+spacing+(1-visibility)*size[0]+c*delta, // higher by delta each time
                              spacing+thickness); // always the same
                }
                // remove cards + spacing around them
                for(c=[0:(cards-1)]) {
                    // calculated shift on Y axis by experimenting and a lot of drawings :)
                    // also moved up on Z by thickness + deltas
                    translate([0,c*extra-((cards-1)*extra)/2,thickness+c*delta])
                    #block(size[1]+2*spacing,
                           size[2]+2*spacing,
                           size[0]+2*spacing,
                           spacing);
                }
            }
        }
    }
}

cardholder();
