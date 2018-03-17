length = 40;
diameter = 8;
holderD = 17;

suckerLength = 10;
suckerD = 10;

spacing = 2;

cylinder(h = length, d = diameter, $fn = 360);

translate([0, 0, length]) difference()
{
	cylinder(h = suckerLength + spacing, d = holderD, $fn = 360);

	translate([0, 0, spacing])
		cylinder(h = suckerLength + 1, d = suckerD, $fn = 360);
};
