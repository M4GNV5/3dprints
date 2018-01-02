radius = 23.5 / 2;
height = 2.5;

gripHeight = 0.2;
gripWidth = 0.5;

depth = 1;
textSize = 2;
textPadding = 1;
label = ["Hallo", "Welt", "foo", "bar"];
bottomLabel = ["BNV"];


innerHeight = height - 2 * gripHeight;
innerRadius = radius - 2 * gripWidth;

difference()
{
	translate([0, 0, -gripHeight])
		cylinder(h = height, r1 = radius, r2 = radius);

	translate([0, 0, -gripHeight - 0.1])
		cylinder(h = height + 0.2, r1 = innerRadius, r2 = innerRadius);
};

difference()
{
	cylinder(h = innerHeight, r1 = innerRadius, r2 = innerRadius);

	labelHeight = len(label) * (textSize + textPadding) - textPadding;
	for(i = [0 : len(label) - 1])
	{
		y = labelHeight / 2 - i * (textSize + textPadding) - textSize;
		echo(i, y, labelHeight);

		translate([0, y, innerHeight - depth + 0.1])
			linear_extrude(depth)
			text(label[i], textSize, halign = "center");
	}

	bottomLabelHeight = len(bottomLabel) * (textSize + textPadding) - textPadding;
	for(i = [0 : len(bottomLabel) - 1])
	{
		y = bottomLabelHeight / 2 - i * (textSize + textPadding) - textSize;

		translate([0, y, -0.1])
			mirror([1, 0, 0])
			linear_extrude(depth)
			text(bottomLabel[i], textSize, halign = "center");
	}
};
