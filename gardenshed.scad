height = 200;
depth = 195.4;
width = 195.4;

roofOverlap = 15;
roofAngle = 10;

beamCountWidth = 3;
beamCountDepth = 3;
beamWidth = 6;
beamDepth = 6;

boardHeight = 11.5;
boardThickness = 2.3;
boardSpacing = 0.5;

plateWidth = 62.5;
plateHeight = 1.2;

widthMinOne = width - beamWidth;
depthMinOne = depth - beamDepth;

beamSpacing = depthMinOne / (beamCountDepth - 1);

blankBeamBottomHeight = 17;

useActualWallHeight = true;

// einschlaghülse: 10.95€
// beam: 6.4€
// board: 5€
// coating: 81.95€
// roof plate: 9.67€
// price = 8 * 10.95 + 15 * 6.4 + 60 * 5 + 81.95 + 4 * 9.67 = 604.23



// beams
module beamRow(placeMiddle, beamHeight) {
    for(y = [0 : beamSpacing : depthMinOne]) {
        if(placeMiddle || y == 0 || y == depthMinOne) {
            echo("BEAM", beamWidth, beamDepth, beamHeight);
            translate([0, y, 0])
                cube([beamWidth, beamDepth, beamHeight]);
        }
    }
}
// diagonal beams for stability
module stabilityBeam(beamHeight) {
    for(y = [0 : beamSpacing : depthMinOne - 1]) {
        stabilityBeamAngle = -1 * asin(beamSpacing / beamHeight);
        echo("STABILITY BEAM", stabilityBeamAngle, beamHeight, beamDepth, beamWidth);
        translate([0, y, 0])
            rotate([stabilityBeamAngle, 0, 0])
                cube([beamDepth, beamWidth, beamHeight]);
    }
}
module beams() {
    for(x = [0 : beamSpacing : widthMinOne]) {
        beamHeight = height - x * tan(roofAngle);
        translate([x, 0, 0])
            union() {
                if(x == 0 || x == widthMinOne) {
                    stabilityBeam(beamHeight);
                }
                beamRow(x == 0 || x == widthMinOne, beamHeight);
            }
    }
}

module roof(enablePrint = false) {
    roofLength = (width + 2 * roofOverlap) / cos(roofAngle);

    // roof beams
    for(y = [0 : beamSpacing : depthMinOne]) {
        if(enablePrint) {
            echo("ROOF BEAM", roofLength, beamDepth, beamWidth);
        }
        translate([-roofOverlap, y, height])
            rotate([0, roofAngle, 0])
                cube([roofLength, beamDepth, beamWidth]);
    }

    // roof plates
    translate([-roofOverlap, -roofOverlap, height + beamWidth])
        rotate([0, roofAngle, 0])
            union() {
                for(x = [0 : plateWidth : roofLength]) {
                    actualWidth = x + plateWidth > roofLength ? roofLength - x : plateWidth;
                    if(enablePrint) {
                        echo("ROOF PLATE", actualWidth, depth + 2 * roofOverlap, plateHeight);
                    }
                    translate([x, 0, 0])
                        cube([actualWidth, depth + 2 * roofOverlap, plateHeight]);
                }
            }
}

//wall 
module wall(width, wallHeight) {
    usedWallHeight = useActualWallHeight ? wallHeight - boardHeight : height;
    for(z = [blankBeamBottomHeight : boardHeight + boardSpacing : usedWallHeight]) {
        echo("WALL BOARD", width, boardThickness, boardHeight);
        translate([0, 0, z])
            cube([width, boardThickness, boardHeight]);
    }
}

// all walls
union() {
    translate([0, -boardThickness, 0])
        wall(depth, height - widthMinOne * tan(roofAngle));

    translate([0, depth, 0])
        wall(depth, height - widthMinOne * tan(roofAngle));

    translate([0, -boardThickness, 0])
        rotate([0, 0, 90])
            wall(depth + 2 * boardThickness, height);

    translate([width + boardThickness, -boardThickness, 0])
        rotate([0, 0, 90])
            wall(depth + 2 * boardThickness, height - widthMinOne * tan(roofAngle));
}

difference() {
    beams();
    roof();
}

roof(true);
