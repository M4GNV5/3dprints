$fn = 120;

woodThickness = 10;
plateSize = [350, woodThickness, 300];
boxDepth = 120;

schukoMargin = 20;
schukoSize = [74, 55, 82];

ceeRed16Margin = 50;
ceeRed16Base = [83, 9, 93];
ceeRed16Angle = 20;
ceeRed16Diameter = 69;
ceeRed16Length = 120; // 131

module echoedCube(name, size)
{
	cube(size);
	echo(name, [for (i = size) if(i != woodThickness) i]);
};

module schuko()
{
	translate([0, -schukoSize[1], -schukoSize[2]])
		cube(schukoSize);
};

module ceeRed16()
{
	translate([0, -ceeRed16Base[1], -ceeRed16Base[2]])
		cube(ceeRed16Base);

	rotYOffset = sin(ceeRed16Angle) * ceeRed16Length;
	translate([
			ceeRed16Base[0] / 2,
			-ceeRed16Diameter / 2 - rotYOffset,
			-ceeRed16Length
		])
		rotate([-ceeRed16Angle, 0, 0])
		cylinder(h=ceeRed16Length, d=ceeRed16Diameter);
}

//backplate
echoedCube("backplate", plateSize);

//front plate
translate([0, -boxDepth - woodThickness, 0])
	%echoedCube("fontplate", plateSize);

//top plate
translate([woodThickness, -boxDepth, plateSize[2] - woodThickness])
	echoedCube("top plate", [
		plateSize[0] - 2 * woodThickness,
		boxDepth,
		woodThickness
	]);

//side plates
translate([0, -boxDepth, 0])
	echoedCube("side plate", [woodThickness, boxDepth, plateSize[2]]);
translate([plateSize[0] - woodThickness, -boxDepth, 0])
	echoedCube("side plate", [woodThickness, boxDepth, plateSize[2]]);

// schukos
for(i = [0:2])
{
	posX = (i + 0.5) * plateSize[0] / 3 - schukoSize[0] / 2;
	translate([posX, 0, plateSize[2] - schukoMargin])
		schuko();
}

// cee red
translate([
		plateSize[0] / 2 - ceeRed16Base[0] / 2,
		0,
		plateSize[2] - schukoMargin - ceeRed16Margin - schukoSize[2]
	])
	ceeRed16();
