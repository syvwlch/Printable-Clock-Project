use <mcad/involute_gears.scad>
include <clockworkLibrary.scad> // version 9

// Overall Parameters
scale=1;					// scaling factor for the whole model
printLimit=80*scale;			// diameter of the largest circle that can be printed on the 'bot
$fs=0.5*scale;				// controls resolution for small details

thickness=3*scale; 			// thickness along the Z axis
pinRadius=1*scale; 			// radius of the pins (0 if not using any) 
sleeveThickness=2*scale; 		// thickness of the sleeves fitting over the pins, or over each other
tightFit=0.25*scale; 			// clearance between hands and sleeves
clearance=0.5*scale; 			// clearance between pin and sleeve, or between sleeve and sleeve
tightFit=0.25*scale;			// clearance between hands and sleeves
clearance=0.5*scale;			// clearance between pin and sleeve, or between sleeve and sleeve
spokeWidth=3*scale; 			// width of the spokes

// Escapement Wheel Parameters
numberTeeth=15; 			// number of teeth in the escapement wheel
toothLength=15*scale; 			// length of the tooth along longest face and to inner radius of the wheel
toothLean=30; 				// how much the tooth leans over, clockwise, in degrees
toothSharpness=10; 			// the angle between the two side of each tooth
clubSize=0.2;				// relative size of the club on the teeth
clubAngle=22.5;				// impulse face angle

axis_separation=0.5*printLimit*3.2/3; 	// distance between consecutive gear shafts 

pinion8=6;					// number of teeth on the pinion
ratio8=-2.5;				// gear ratio with the previous wheel

circular_pitch8=axis_separation/(abs(ratio8)+1)/pinion8*360;


// Escapement Parameters
toothSpan=3.5; 				// how many teeth the escapement spans
faceAngle=8; 				// how many degrees the impulse face covers seen from the hub of the escapement wheel
armAngle=24; 				// angle of the escapement's arms
armWidth=4*scale; 			// width of the escapement's arms
hubWidth=10*scale; 			// width of the escapement's hub
hubHeight=thickness; 			// thickness of the escapement's hub


// Gear Parameters
pressureAngle=28;			// pressure angle for all the gears
rimWidth=4*scale;			// width of the rim, measured from the dedendum (bottom of the teeth)
gearClearance=0.2*scale;		// clearance for all the gears
gearBacklash=0.1*scale;		// backlash for all the gears

// Colors
red=		[1,0,0];
green=	[0,1,0];

// Module definitions

module animateEscapement(escAngle,wheelAngle,escapementColor=green)
{
	radius=axis_separation-(pinRadius+sleeveThickness+clearance);
	bore_radius=pinRadius+sleeveThickness+clearance; 

	color(escapementColor)
	rotate(escAngle,[0,0,1])
	import("Outputs/Escapement-Animation-Escapement.stl");

	placeEscapement(180,radius,numberTeeth,toothSpan)
	rotate(wheelAngle,[0,0,1])
	import("Outputs/Escapement-Animation-Wheel.stl");
}

module exportEscapement()
{
	radius=axis_separation-(pinRadius+sleeveThickness+clearance);
	bore_radius=pinRadius+sleeveThickness+clearance; 

	escapement(
		radius=radius, 
		thickness=thickness,
		faceAngle=faceAngle,
		armAngle=armAngle,
		armWidth=armWidth,
		numberTeeth=numberTeeth,
		toothSpan=toothSpan,
		hubWidth=hubWidth,
		hubHeight=hubHeight,
		bore=bore_radius,
		negative_space=false,
		space=0.1,
		max_swing=6,
		entryPalletAngle=45-toothLean+clubAngle, 
		exitPalletAngle=45-toothLean+clubAngle);
}

module exportWheel()
{
	radius=axis_separation-(pinRadius+sleeveThickness+clearance);
	bore_radius=pinRadius+sleeveThickness+clearance; 

	pinionEscapementWheel(
		radius=radius, 
		escapement_teeth=numberTeeth,
		tooth_length=toothLength,
		tooth_lean=toothLean,
		tooth_sharpness=toothSharpness,
		small_gear_teeth=pinion8,
		small_gear_circular_pitch=circular_pitch8,
		gear_clearance=gearClearance,
		gear_backlash=gearBacklash,
		gear_spacer=0.5,
		pressure_angle=14.5,
		twist_factor=0,
		rim_width=rimWidth,
		sleeve_level=0,
		pin_radius=pinRadius,
		sleeve_thickness=sleeveThickness,
		loose_fit=clearance,
		gear_thickness=thickness,
		sleeve_extension=1*thickness,
		spacer=0,
		spoke_width=spokeWidth,
		notch_angle=0,
		negative_space=false,
		space=0.1,
		clubSize=clubSize,
		clubAngle=clubAngle);
}

// Script

translate([0,30,0])
animateEscapement(0,-0,green);



