number = "5";
height = 200;
layerHeight = 0.2;
font = "Fira Code:style=SemiBold";

$fn = 360;

module screwHole() {
    translate([0, 0, -50]) 
        cylinder(h=100, r=2);

    difference() {
        translate([0, 0, -5]) 
            cylinder(h=100, r=5);

        translate([2, -10, -5]) 
            cube([10, 20, 2 * layerHeight]);

        translate([-12, -10, -5]) 
            cube([10, 20, 2 * layerHeight]);
    }
};

module distancer() {
    translate([0, 0, -10])
        cylinder(h=10, r=8);
}

difference() {
    union() {
        linear_extrude(height = 10)
            text(number, height, font);

        translate([130, 65, 0])
            distancer();

        translate([48, 145, 0])
            distancer();
    }

    translate([130, 65, 0])
        screwHole();

    translate([48, 145, 0])
        screwHole();
}


