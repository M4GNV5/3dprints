thickness = 0.5;
label = "J";

bottomSize = [18, 18];
topSize = [15, 15];
nudgeSize = 3;
pressRadius = 2;
pressHolderOffset = 2;
connectorSize = [9.5, 9.5];
keyHeight = 5;
totalHeight = 10;

translate([0, 0, totalHeight / 2]) difference()
{
	cube([connectorSize[0], connectorSize[1], totalHeight], true);
	cube([connectorSize[0] - 2 * thickness, connectorSize[1] - 2 * thickness, totalHeight + 1], true);
	translate([0, -connectorSize[0] / 2 + thickness / 2, 0]) cube([nudgeSize, 2 * thickness, totalHeight + 1], true);
};

pressHolderLength = sqrt(connectorSize[0] * connectorSize[0] + connectorSize[1] * connectorSize[1]) - thickness;
translate([0, 0, totalHeight / 2 + pressHolderOffset / 2])
{
	rotate([0, 0, 45]) cube([pressHolderLength, thickness, totalHeight - pressHolderOffset], true);
	rotate([0, 0, -45]) cube([pressHolderLength, thickness, totalHeight - pressHolderOffset], true);
};
translate([0, 0, pressHolderOffset]) cylinder(totalHeight - pressHolderOffset, r = pressRadius, true, $fn = 100);

module pyramid(h, l1, w1, l2, w2)
{
	dl = (l1 - l2) / 2;
	dw = (w1 - w2) / 2;
	polyhedron([
			[0, 0, 0], [l1, 0, 0], [l1, w1, 0], [0, w1, 0],
			[dl, dw, h], [l2 + dl, dw, h], [l2 + dl, w2 + dw, h], [dl, w2 + dw, h],
		],
		[
			[0, 1, 2, 3], [7, 6, 5, 4], //bottom, top
			[4, 5, 1, 0], [5, 6, 2, 1], [6, 7, 3, 2], [7, 4, 0, 3] //4 sides
		]
	);
};

translate([-bottomSize[0] / 2, -bottomSize[1] / 2, keyHeight]) difference()
{
	pyramid(keyHeight, bottomSize[0], bottomSize[1], topSize[0], topSize[1]);

	translate([thickness, thickness, -1e-3]) pyramid(keyHeight - thickness,
		bottomSize[0] - 2 * thickness, bottomSize[1] - 2 * thickness,
		topSize[0] - 2 * thickness, topSize[1] - 2 * thickness
	);
}

#translate([0, 0, totalHeight])
	linear_extrude(thickness)
	text(label, 12, valign = "center", halign = "center");
