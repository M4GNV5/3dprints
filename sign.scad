label = ["HALLO", "WELT"];
textSize = 7;
textPadding = 1;
textFont = "Liberation Serif";
textThickness = 1;

height = 50;
width = 30;
thick = 2;
connectorHeight = 5;
connectionHeight = 1;
connectionDepth = 1;
connectionAngle = 30;
feetHeight = 15;
feetWidth = 5;



module generateBody()
{
	translate([connectorHeight, 0, 0])
		cube([height, width, thick]);

	translate([connectorHeight + height, 0, 0])
		cube([feetHeight, feetWidth, thick]);
	translate([connectorHeight + height, width - feetWidth, 0])
		cube([feetHeight, feetWidth, thick]);
};
generateBody();
mirror() generateBody();

module generateText()
{
	totalTextHeight = len(label) * (textSize + textPadding) - textPadding;
	for(i = [0 : len(label) - 1])
	{
		y = -totalTextHeight / 2 + i * (textSize + textPadding) + textSize;

		echo(totalTextHeight, y);
		translate([y, 0, 0])
			rotate([0, 0, 90])
			linear_extrude(textThickness)
			text(label[i], textSize, textFont, halign = "center");
	}
};

#translate([connectorHeight + height / 2, width / 2, thick])
	generateText();
#translate([-connectorHeight - height / 2, width / 2, thick])
	rotate([0, 0, 180]) generateText();

translate([0, 0, 0])
	cube([connectorHeight, width / 3, thick]);

translate([-connectorHeight, width / 3, 0])
	cube([connectorHeight, width / 3, thick]);

difference()
{
	translate([0, width * 2 / 3, 0])
		cube([connectorHeight, width / 3, thick]);

	#translate([connectorHeight - 1, width * 2 / 3 - 0.1, 0])
		rotate([0, connectionAngle - 90, 0])
		cube([connectionHeight, connectionDepth + 0.1, 10]);
};
