groundLength = 7226;
groundWidth = 3930;
groundHeight = 200;

wallsHeight = 3701 + groundHeight;
wallsThickness = 257;

terraceLength = 931;
windowLength = 120;

bathroomLength = 71 + 1947 + 218;
bathroomWidth = 74 + 850 + 77;
bathroomHeight = 2122;
bathroomYOffset = 1769 + wallsThickness;

technicLength = 69 + 1475;
technicWidth = groundWidth - bathroomYOffset - bathroomWidth - wallsThickness;
technicHeight = 1369;

ventLength = 218;
ventWidth1 = bathroomWidth;
ventWidth2 = technicWidth;

stairStepLength = 228;
stairStepHeights = [229, 457, 685, 913, 1141];

kitchenLength = 800;
kitchenWidth = 1769;
kitchenHeight = 922;

echo(["technicWidth", technicWidth]);



// ground plate
cube([groundLength, groundWidth, groundHeight]);

// left wall
difference()
{
	translate([0, groundWidth - wallsThickness, 0])
		cube([groundLength, wallsThickness, wallsHeight]);

	linear_extrude(wallsHeight + 1, center = false)
		polygon([
			[-1, groundWidth - 50],
			[-1, groundWidth - wallsThickness - 1],
			[terraceLength, groundWidth - wallsThickness - 1]
		]);
}

// right wall
difference()
{
	cube([groundLength, wallsThickness, groundHeight + 100]);

	linear_extrude(groundHeight + 100 + 1, center = false)
		polygon([
			[-1, 50],
			[-1, wallsThickness + 1],
			[terraceLength, wallsThickness + 1]
		]);
}

// back wall
translate([groundLength - wallsThickness, 0, 0])
	difference()
	{
		cube([wallsThickness, groundWidth, wallsHeight]);

		translate([-1, 569, 742 + groundHeight])
			cube([wallsThickness + 2, 644, 1200]);
		
		translate([-1, 569, 2302 + groundHeight])
			cube([wallsThickness + 2, 644, 1200]);
	};

// front wall (window)
translate([200, 0, groundHeight + 2124])
	cube([terraceLength + windowLength + 205 - 100, groundWidth, 100]);
translate([terraceLength, 0, 0])
	difference()
	{
		cube([windowLength, groundWidth, wallsHeight]);

		translate([-1, 586, groundHeight])
			cube([windowLength + 2, 850, 2084]);

		windowYOffset = groundWidth - wallsThickness - 586 - 850 - 120;
		translate([-1, 586 + 850 + 120, groundHeight])
			cube([windowLength + 2, windowYOffset, 2084]);

		translate([-1, wallsThickness, groundHeight + 2264])
			cube([
				windowLength + 2,
				groundWidth - 2 * wallsThickness,
				wallsHeight - groundHeight - 2264 - 100,
			]);
	};

//bathroom
translate([
	groundLength - wallsThickness - bathroomLength,
	bathroomYOffset,
	groundHeight
])
{
	cube([bathroomLength, 74, bathroomHeight]);
	cube([71, bathroomWidth, bathroomHeight]);

	translate([0, bathroomWidth - 77, 0])
		cube([bathroomLength, 77, bathroomHeight]);
}

//technic
translate([
	groundLength - technicLength - wallsThickness,
	groundWidth - technicWidth - wallsThickness,
	groundHeight
])
	cube([technicLength, technicWidth, technicHeight]);

// vent
translate([
	groundLength - wallsThickness - ventLength,
	bathroomYOffset,
	groundHeight
])
{
	cube([ventLength, bathroomWidth, bathroomHeight]);
	translate([0, ventWidth1, 0])
		cube([ventLength, ventWidth2, wallsHeight - groundHeight]);
}

// stairs
translate([
	groundLength - wallsThickness - technicLength
		- len(stairStepHeights) * stairStepLength,
	groundWidth - wallsThickness - technicWidth,
	groundHeight
])
	for (i = [0 : len(stairStepHeights) - 1])
		translate([i * stairStepLength, 0, 0])
			cube([stairStepLength, technicWidth, stairStepHeights[i]]);

// last step
translate([
	groundLength - wallsThickness - technicLength / 2 - ventLength / 2,
	groundWidth - wallsThickness - technicWidth,
	groundHeight + technicHeight
])
	cube([technicLength / 2, technicWidth, 387]);

// 2nd floor
/*
translate([
	groundLength - wallsThickness - bathroomLength,
	0,
	bathroomHeight + groundHeight
])
{
	cube([bathroomLength, bathroomYOffset + bathroomWidth, 100]);
}
*/

// kitchen
translate([
	groundLength - wallsThickness - kitchenLength,
	wallsThickness,
	groundHeight
])
{
	cube([kitchenLength, kitchenWidth, kitchenHeight - 100]);
	translate([-50, 0, kitchenHeight - 100])
		cube([kitchenLength + 50, kitchenWidth, 100]);
}