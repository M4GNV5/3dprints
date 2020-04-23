width = 58 + 2 * 3.4;
height = 99.7;
depth = 39.5;

holder_x = 3.4;
holder_y = 5.4;

plate_width = width - 2 * holder_x;
plate_height = 1.5;

middle_layer_height = height - plate_height - 35;

module main_holder()
{
	translate([-width / 2, -depth / 2, 0])
		cube([holder_x, holder_y, height]);

	translate([-width / 2, depth / 2 - holder_y, 0])
		cube([holder_x, holder_y, height]);

	translate([width / 2 - holder_x, -depth / 2, 0])
		cube([holder_x, holder_y, height]);

	translate([width / 2 - holder_x, depth / 2 - holder_y, 0])
		cube([holder_x, holder_y, height]);

	for(i = [0:3])
		echo("Holder", [holder_x, holder_y, height]);
};

module plate_with_holder()
{
	//holder
	translate([width / 2 - 2 * holder_x, -depth / 2, 0])
		cube([holder_x, depth, holder_y]);

	translate([-width / 2 + holder_x, -depth / 2, 0])
		cube([holder_x, depth, holder_y]);

	for(i = [0:1])
		echo("Plate Holder", [holder_x, depth, holder_y]);
	
	//plate
	translate([-plate_width / 2, -depth / 2, holder_y])
		cube([plate_width, depth, plate_height]);

	echo("Plate", [plate_width, depth, plate_height]);
}

module shelf()
{
	main_holder();
	
	plate_with_holder();

	translate([0, 0, middle_layer_height - holder_y])
		plate_with_holder();

	translate([0, 0, height - holder_y - plate_height])
		plate_with_holder();

	//back plane
	translate([-width / 2, depth / 2, 0])
		cube([width, plate_height, height]);

	echo("Back Plane", [width, plate_height, height]);
};

translate([2 * width - 1.5 * holder_x, 0, 0])
	union()
	{
		translate([-1.5 * width + 1.5 * holder_x, 0, 0])
			shelf();

		translate([-width / 2 + holder_x / 2, 0, 0])
			shelf();

		translate([width / 2 - holder_x / 2, 0, 0])
			shelf();

		translate([1.5 * width - 1.5 * holder_x, 0, 0])
			shelf();

		//end plate
		translate([2 * width - 1.5 * holder_x, -depth / 2, 0])
			cube([plate_height, depth, height]);

		echo("Side Plane", [plate_height, depth, height]);
	};