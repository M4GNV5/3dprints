//This part just holds the phone, a second part which gets sticked to the car in some way is needed
//in my case i used a model from the link below for my Renault Twizy
//https://www.twizy-forum.de/zubehoer-twizy/82990-3d-druck-twizplay-halter-fuer-die-a-saeule

thickness = 1;
height = 130;
width = 62;

screwPosition = 10;
screwDiameter = 2;

holderHeight = 10;
holderWidth = 15;

difference()
{
	cube([width, height, thickness], true);
	translate([-screwPosition, 0, -1]) cylinder(r = screwDiameter, h = thickness + 2);
	translate([screwPosition, 0, -1]) cylinder(r = screwDiameter, h = thickness + 2);
};

module bottomHolder()
{
	translate([-width / 2, -height / 2, thickness / 2]) difference()
	{
		cube([holderWidth, holderWidth, holderHeight + thickness]);
		translate([holderWidth + thickness, holderWidth + thickness, -2])
			cylinder(r = holderWidth, h = holderHeight + 2);
	};
};
bottomHolder();
mirror([1, 0, 0]) bottomHolder();

module topHolder()
{
	translate([-width / 2, height / 2 - holderWidth, thickness / 2]) difference()
	{
		cube([holderWidth, holderWidth, holderHeight]);
		translate([thickness, -1, -thickness - 1])
			cube([holderWidth + 2 * thickness, holderWidth + 2, holderHeight + 1]);
	};
};
topHolder();
mirror([1, 0, 0]) topHolder();
