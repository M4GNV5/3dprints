length = 10;
diameter = 14;

suckerLength = 10;
suckerD = 10;
spacing = 2;

stepperConnectorD = 5;
stepperConnectorHeight = 3;
stepperConnectorLength = 6;

difference()
{
	cylinder(h = length, d = diameter, $fn = 360);

	translate([0, 0, -1]) difference()
	{
		cylinder(h = stepperConnectorHeight + 1, d = stepperConnectorD, $fn = 360);

		translate([-stepperConnectorD / 2, stepperConnectorHeight / 2, -1])
			cube([stepperConnectorD, stepperConnectorD, stepperConnectorHeight + 3]);

		translate([-stepperConnectorD / 2, -stepperConnectorD - stepperConnectorHeight / 2, -1])
			cube([stepperConnectorD, stepperConnectorD, stepperConnectorHeight + 3]);
	};
};

translate([0, 0, length]) difference()
{
	cylinder(h = suckerLength + spacing, d = diameter, $fn = 360);

	translate([0, 0, spacing])
		cylinder(h = suckerLength + 1, d = suckerD, $fn = 360);
};
