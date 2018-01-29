//This part just holds the phone, a second part which gets sticked to the car in some way is needed
//in my case i used a model from the link below for my Renault Twizy
//https://www.twizy-forum.de/zubehoer-twizy/82990-3d-druck-twizplay-halter-fuer-die-a-saeule

thickness = 1;
height = 130;
width = 64;

screwPosition = 13.5;
screwDiameter = 3;
screwWindowDepth = 2;
screwWindowSpacing = 5;

holderThickness = 3;
holderHeight = 13;
holderWidth = 15;

translate([0, 0, -thickness - screwWindowDepth]) difference()
{
	translate([-width / 2, -height / 2, 0])
		cube([width, height, thickness + screwWindowDepth]);

	windowWidth = 2 * screwPosition + screwDiameter + 2 * screwWindowSpacing;
	translate([-windowWidth / 2, -screwWindowSpacing - screwDiameter / 2, thickness])
		cube([windowWidth, 2 * screwWindowSpacing + screwDiameter, screwWindowDepth + 1]);

	translate([-screwPosition, 0, - 1]) cylinder(d = screwDiameter, h = 2 * thickness + 2, $fn = 360);
	translate([screwPosition, 0, - 1]) cylinder(d = screwDiameter, h = 2 * thickness + 2, $fn = 360);
};

module bottomHolder()
{
	translate([-width / 2, -height / 2, 0]) difference()
	{
		cube([holderWidth, holderWidth, holderHeight + holderThickness]);
		translate([holderWidth + holderThickness, holderWidth + holderThickness, -2])
			cylinder(r = holderWidth, h = holderHeight + 2);
	};
};
bottomHolder();
mirror([1, 0, 0]) bottomHolder();

translate([-width / 2, height / 2 - holderWidth, 0])
{
	difference()
	{
		cube([holderWidth + holderThickness, holderWidth, holderHeight + holderThickness]);
		translate([holderThickness, -1, -1])
			cube([holderWidth + 2 * thickness, holderWidth + 2, holderHeight + 1]);
	};
	translate([3, 0, holderHeight - 3]) difference()
	{
		cube([3, holderWidth, 3]);
		translate([2.5, -1, 0.5])
			rotate([-90, 0, 0])
			cylinder(d = 5.1, h = holderWidth + 2, $fn = 360);
	};
	translate([3, 0, 0]) difference()
	{
		cube([3, holderWidth, 3]);
		translate([2.5, -1, 2.5])
			rotate([-90, 0, 0])
			cylinder(d = 5.1, h = holderWidth + 2, $fn = 360);
	};
};
