$fn = 180;

difference()
{
	union()
	{
		cylinder(d=6, h=12, center=true);
		translate([0, 0, 6]) sphere(3.25, $fn=30);
		translate([0, 0, 3]) sphere(3.25, $fn=30);
		translate([0, 0, 0]) sphere(3.25, $fn=30);

	};

	translate([0, 0, 6]) cube([1, 10, 16], center=true);
	translate([0, 0, 6]) cube([10, 1, 16], center=true);

};

hull()
{
	translate([0, 0, -6]) cylinder(d=20, h=1, center=true);

	translate([0, 0, -7]) cylinder(d=18, h=1, center=true);

	translate([0, 0, -8]) cylinder(d=8, h=1, center=true);
};