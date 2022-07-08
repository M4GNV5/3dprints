// 86 x 54 x 9 
width = 52;
height = 85;
radius = 5;

spacing = 5;

$fn = 120;

module inverseArc() {
    #translate([0, 0, -1])
        difference() {
            cube([radius + 1, radius + 1, spacing + 2]);

            translate([0, 0, 4])
                cylinder(spacing + 4, radius, radius, true);
        }
}

difference() {
    cube([width, height, spacing]);

    translate([radius, radius, 0])
        rotate([0, 0, 180])
        inverseArc();

    translate([width - radius, radius, 0])
        rotate([0, 0, 270])
        inverseArc();

    translate([radius, height - radius, 0])
        rotate([0, 0, 90])
        inverseArc();

    translate([width - radius, height - radius, 0])
        rotate([0, 0, 0])
        inverseArc();
}
