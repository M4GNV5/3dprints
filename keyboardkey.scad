thickness = 1;
label = "J";

bottomSize = [18, 18];
topSize = [15, 15];
connectorSize = [10, 10];
keyHeight = 5;
totalHeight = 10;

translate([0, 0, totalHeight / 2 - thickness / 2]) difference()
{
	cube([connectorSize[0] + thickness, connectorSize[1] + thickness, totalHeight - thickness], true);
	cube([connectorSize[0], connectorSize[1], totalHeight + thickness], true);
};

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
	translate([0, 0, -thickness * 2]) pyramid(keyHeight, bottomSize[0], bottomSize[1], topSize[0], topSize[1]);
}

#translate([0, 0, totalHeight])
	linear_extrude(thickness)
	text(label, 12, valign = "center", halign = "center");
