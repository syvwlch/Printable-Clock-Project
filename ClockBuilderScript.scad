/* The Printable Clock Project by Syvwlch, 
with help from MakerBlock, rustedrobot, barrychuck, 
and many others at Thingiverse. 

This script builds a clock from parameters defined in the script that calls it via an <include>. It does not work by itself.

CC-A-SA licensed.*/

use <mcad/involute_gears.scad>
include <clockworkLibrary.scad> 	// version 12

// Overall Parameters
$fs=0.25*scale;				// controls resolution for small details

	//pinRadius 		has been moved to the clock parameter script
	//sleeveThickness 	has been moved to the clock parameter script
	//tightFi 			has been moved to the clock parameter script
	//clearance 		has been moved to the clock parameter script
	//spokeWidth 		has been moved to the clock parameter script
	//numberSpoke 		has been moved to the clock parameter script

// Drum Parameters
//stringHoleRadius=1*scale;		// radius of the holes in the drum


// Escapement Wheel Parameters
numberTeeth=15; 			// number of teeth in the escapement wheel
toothLength=15*scale; 			// length of the tooth along longest face and to inner radius of the wheel
toothLean=33; 				// how much the tooth leans over, clockwise, in degrees
toothSharpness=10; 			// the angle between the two side of each tooth
clubSize=0.2; 				// relative size of the club on the teeth 
clubAngle=22.5; 				// impulse face angle


// Escapement Parameters
toothSpan=3.5; 				// how many teeth the escapement spans
faceAngle=6; 				// how many degrees the impulse face covers seen from the hub of the escapement wheel
armAngle=24; 				// angle of the escapement's arms
maxSwing=8;				// maximum swing of the escapement, in degrees
armWidth=4*scale; 			// width of the escapement's arms
hubWidth=10*scale; 			// width of the escapement's hub
hubHeight=thickness; 			// thickness of the escapement's hub


// Pendulum Parameters
pendulumLength=printLimit/2-hubWidth;		// length of the pendulum, measured from pin to center of bob
pendulumRadius=hubWidth;				// radius of the bob at the end of the pendulum
snapFitBase=pendulumRadius/2;			// dimensions of the snap-fit end on the pendulum arm
snapFitTop=2*snapFitBase;				// dimensions of the snap-fit end on the pendulum arm
snapFitHeight=snapFitBase;				// dimensions of the snap-fit end on the pendulum arm


// Gear Parameters
pressureAngle=14.5;			// pressure angle for all the gears
rimWidth=4*scale;			// width of the rim, measured from the dedendum (bottom of the teeth)
gearClearance=0.2*scale;		// clearance for all the gears - default=0.2
gearBacklash=0.2*scale;		// backlash for all the gears
gearSpacer=0.5*scale;			// assymetrical axial spacer so the large gear doesn't run into the shoulder supporting the small gear


// Clock calculations

	// radius of the escapement wheel 
	escapement_radius= 0.5*axis_separation/cos(180/numberTeeth*toothSpan);

	circular_pitch1=axis_separation/(abs(ratio1)+1)/pinion1*360; 
	circular_pitch2=axis_separation/(abs(ratio2)+1)/pinion2*360;
	circular_pitch3=axis_separation/(abs(ratio3)+1)/pinion3*360;
	circular_pitch4=axis_separation/(abs(ratio4)+1)/pinion4*360;
	circular_pitch5=axis_separation/(abs(ratio5)+1)/pinion5*360;
	circular_pitch6=axis_separation/(abs(ratio6)+1)/pinion6*360;
	circular_pitch7=axis_separation/(abs(ratio7)+1)/pinion7*360;
	circular_pitch8=axis_separation/(abs(ratio8)+1)/pinion8*360;

	fold_angle1=0; 
	fold_angle2=(fold_angle+fold_angle1)*ratio1+( pinion1/2==floor(pinion1/2) ? 180/pinion1 : 0);
	fold_angle3=(fold_angle+fold_angle2)*ratio2+( pinion2/2==floor(pinion2/2) ? 180/pinion2 : 0);
	fold_angle4=(fold_angle+fold_angle3)*ratio3+( pinion3/2==floor(pinion3/2) ? 180/pinion3 : 0);
	fold_angle5=(fold_angle+fold_angle4)*ratio4+( pinion4/2==floor(pinion4/2) ? 180/pinion4 : 0);
	fold_angle6=(fold_angle+fold_angle5)*ratio5+( pinion5/2==floor(pinion5/2) ? 180/pinion5 : 0);
	fold_angle7=(fold_angle+fold_angle6)*ratio6+( pinion6/2==floor(pinion6/2) ? 180/pinion6 : 0);
	fold_angle8=(fold_angle+fold_angle7)*ratio7+( pinion7/2==floor(pinion7/2) ? 180/pinion7 : 0);
	fold_angle9=(fold_angle+fold_angle8)*ratio8+( pinion8/2==floor(pinion8/2) ? 180/pinion8 : 0);
	
	rotation_angle1=rotation_angle; 
	rotation_angle2=rotation_angle1*ratio1;
	rotation_angle3=rotation_angle2*ratio2;
	rotation_angle4=rotation_angle3*ratio3;
	rotation_angle5=rotation_angle4*ratio4;
	rotation_angle6=rotation_angle5*ratio5;
	rotation_angle7=rotation_angle6*ratio6;
	rotation_angle8=rotation_angle7*ratio7;
	rotation_angle9=rotation_angle8*ratio8;

	correction1=		90-clockCorrection+fold_angle1-0*fold_angle; 	// correction angle for hand to be straight at midnight
	correction2=		90-clockCorrection+fold_angle2-1*fold_angle; 	// correction angle for hand to be straight at midnight
	correction3=		90-clockCorrection+fold_angle3-2*fold_angle; 	// correction angle for hand to be straight at midnight
	correction4=		90-clockCorrection+fold_angle4-3*fold_angle; 	// correction angle for hand to be straight at midnight
	correction5=		90-clockCorrection+fold_angle5-4*fold_angle; 	// correction angle for hand to be straight at midnight
	correction6=		90-clockCorrection+fold_angle6-5*fold_angle; 	// correction angle for hand to be straight at midnight
	correction7=		90-clockCorrection+fold_angle7-6*fold_angle; 	// correction angle for hand to be straight at midnight
	correction8=		90-clockCorrection+fold_angle8-7*fold_angle; 	// correction angle for hand to be straight at midnight
	correction9=		90-clockCorrection+fold_angle9-8*fold_angle; 	// correction angle for hand to be straight at midnight

	pendulumCorrection=	-90;								// correction angle for the pendulum line up with wheel 

// Module definitions

module placeWheel(angle,distance,depth) 
{
	child(0);
	
	if($children-1>=1)
	{
		rotate([0,0,angle])
		translate([distance,0,depth])
		{
			child(1);
			if($children-1>=2)
			{
				rotate([0,0,angle])
				translate([distance,0,depth])
				{
					child(2);
					if($children-1>=3)
					{
						rotate([0,0,angle]) 
						translate([distance,0,depth])
						{
							child(3);
							if($children-1>=4)
							{
								rotate([0,0,angle]) 
								translate([distance,0,depth])
								{
									child(4);
									if($children-1>=5)
									{
										rotate([0,0,angle]) 
										translate([distance,0,depth])
										{
											child(5);
											if($children-1>=6)
											{
												rotate([0,0,angle]) 
												translate([distance,0,depth])
												{
													child(6);
													if($children-1>=7)
													{
														rotate([0,0,angle]) 
														translate([distance,0,depth])
														{
															child(7);
															if($children-1>=8)
															{
																rotate([0,0,angle]) 
																translate([distance,0,depth])
																{
																	child(8);
																	if($children-1>=9)
																	{
																		rotate([0,0,angle]) 
																		translate([distance,0,depth])
																		{
																			child(9);
																		}
																	}																							}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

module trapezoidkey(base, top, height, thickness,plug=0) 
{
	linear_extrude(height=thickness, center=true, convexity=10, twist=0) 
	polygon(
		points= [
			[-base/2,0], 
			[-base/2,-plug], 
			[base/2,-plug],
			[base/2,0],
			[top/2, height],
			[-top/2, height] 
			],
		paths= [[0,1,2,3,4,5]],
		convexity=10
		);
}

module ratchet1(negativeSpace=false)
{
	if (gearExists1!=1)
	cube(0);

	if (gearExists1==1)
	ratchetDrum(
		drum_height=			drumHeight-spacer, 
		clockwise=			true,
		large_gear_teeth=		abs(ratio1)*pinion1,
		large_gear_circular_pitch=	circular_pitch1-trimCircularPitch,
		small_gear_teeth=		0,
		small_gear_circular_pitch=	0,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel1,//+1,
		pin_radius=			(sleeveExtension1==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		spacer,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		number_holes=			numberSpokes, 
		hole_radius=			stringHoleRadius,
		notch_angle=			correction1,
		negative_space=		negativeSpace,
		space=				negativeMargin);
}

module ratchet2(negativeSpace=false)
{
	if (gearExists2!=1)
	cube(0);

	if (gearExists2==1)
	ratchetDrum(
		drum_height=			drumHeight-spacer, 
		clockwise=			false,
		large_gear_teeth=		abs(ratio2)*pinion2,
		large_gear_circular_pitch=	circular_pitch2-trimCircularPitch,
		small_gear_teeth=		pinion1,
		small_gear_circular_pitch=	circular_pitch1-trimCircularPitch,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel2,//+1,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		spacer,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		number_holes=			numberSpokes, 
		hole_radius=			stringHoleRadius,
		notch_angle=			correction2,
		negative_space=		negativeSpace,
		space=				negativeMargin);
}

module pinion1(negativeSpace=false)
{
	if (gearExists1==1)
	handNotch(
		notch_height=			drumThickness+sleeveExtension1-handThickness,
		notch_width=			handWidth1,
		sleeve_level=			sleeveLevel1,
		pin_radius=			(sleeveExtension1==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=			correction1,
		negative_space=		negativeSpace)
	ratchetGear(
		drum_height=			drumHeight, 
		clockwise=			true,
		large_gear_teeth=		abs(ratio1)*pinion1,
		large_gear_circular_pitch=	circular_pitch1-trimCircularPitch,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel1,
		pin_radius=			(sleeveExtension1==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		sleeveExtension1,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction1,
		negative_space=		negativeSpace,
		space=				negativeMargin);

	if (gearExists1==2)
	handNotch(
		notch_height=			pinionThickness+sleeveExtension1-handThickness,
		notch_width=			handWidth1,
		sleeve_level=			sleeveLevel1,
		pin_radius=			(sleeveExtension1==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=			correction1,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio1)*pinion1,
		large_gear_circular_pitch=	circular_pitch1-trimCircularPitch,
		small_gear_teeth=		0,
		small_gear_circular_pitch=	0,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel1,
		pin_radius=			(sleeveExtension1==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		sleeveExtension1,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction1,
		negative_space=		negativeSpace,
		space=				negativeMargin);
}

module pinion2(negativeSpace=false)
{
	if (gearExists2==1)
	handNotch(
		notch_height=			drumThickness+sleeveExtension2-handThickness,
		notch_width=			handWidth2,
		sleeve_level=			sleeveLevel2,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=			correction2,
		negative_space=		negativeSpace)
	ratchetGear(
		drum_height=			drumHeight, 
		clockwise=			false,
		large_gear_teeth=		abs(ratio2)*pinion2,
		large_gear_circular_pitch=	circular_pitch2-trimCircularPitch,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel2,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		sleeveExtension2,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction2,
		negative_space=		negativeSpace,
		space=				negativeMargin);

	if (gearExists2==2)
	handNotch(
		notch_height=			pinionThickness+sleeveExtension2-handThickness,
		notch_width=			handWidth2,
		sleeve_level=			sleeveLevel2,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=			correction2,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio2)*pinion2,
		large_gear_circular_pitch=	circular_pitch2-trimCircularPitch,
		small_gear_teeth=		pinion1,
		small_gear_circular_pitch=	circular_pitch1-trimCircularPitch,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel2,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		sleeveExtension2,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction2,
		negative_space=		negativeSpace,
		space=				negativeMargin);

	if (gearExists2==3)
	handNotch(
		notch_height=			pinionThickness+sleeveExtension2-handThickness,
		notch_width=			handWidth2,
		sleeve_level=			sleeveLevel2,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=			correction2,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=		toothSharpness,
		small_gear_teeth=		pinion1,
		small_gear_circular_pitch=	circular_pitch1-trimCircularPitch,
		gear_clearance=		gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=		pressureAngle,
		twist_factor=			twistFactor,
		rim_width=			rimWidth,
		sleeve_level=			sleeveLevel2,
		pin_radius=			(sleeveExtension2==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=		thickness,
		sleeve_extension=		sleeveExtension2,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction2,
		negative_space=		negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=			clubAngle);
}

module pinion3(negativeSpace=false)
{
	if (gearExists3==2)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension3-handThickness,
		notch_width=		handWidth3,
		sleeve_level=		sleeveLevel3,
		pin_radius=			(sleeveExtension3==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction3,
		negative_space=		negativeSpace)
	pinionWheel( 
		large_gear_teeth=		abs(ratio3)*pinion3,
		large_gear_circular_pitch=	circular_pitch3-trimCircularPitch,
		small_gear_teeth=		pinion2,
		small_gear_circular_pitch=	circular_pitch2-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel3,
		pin_radius=				(sleeveExtension3==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension3,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction3,
		negative_space=			negativeSpace,
		space=				negativeMargin);

	if (gearExists3==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension3-handThickness,
		notch_width=		handWidth3,
		sleeve_level=		sleeveLevel3,
		pin_radius=			(sleeveExtension3==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction3,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion2,
		small_gear_circular_pitch=	circular_pitch2-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel3,
		pin_radius=				(sleeveExtension3==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension3,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction3,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}

module pinion4(negativeSpace=false)
{
	if (gearExists4==2)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension4-handThickness,
		notch_width=		handWidth4,
		sleeve_level=		sleeveLevel4,
		pin_radius=			(sleeveExtension4==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction4,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio4)*pinion4,
		large_gear_circular_pitch=	circular_pitch4-trimCircularPitch,
		small_gear_teeth=		pinion3,
		small_gear_circular_pitch=	circular_pitch3-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel4,
		pin_radius=				(sleeveExtension4==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension4,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction4,
		negative_space=			negativeSpace,
		space=				negativeMargin);

	if (gearExists4==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension4-handThickness,
		notch_width=		handWidth4,
		sleeve_level=		sleeveLevel4,
		pin_radius=			(sleeveExtension4==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction4,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion3,
		small_gear_circular_pitch=	circular_pitch3-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel4,
		pin_radius=				(sleeveExtension4==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension4,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction4,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}

module pinion5(negativeSpace=false)
{
	if (gearExists5==2)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension5-handThickness,
		notch_width=		handWidth5,
		sleeve_level=		sleeveLevel5,
		pin_radius=			(sleeveExtension5==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction5,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio5)*pinion5,
		large_gear_circular_pitch=	circular_pitch5-trimCircularPitch,
		small_gear_teeth=		pinion4,
		small_gear_circular_pitch=	circular_pitch4-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel5,
		pin_radius=				(sleeveExtension5==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension5,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction5,
		negative_space=			negativeSpace,
		space=				negativeMargin);

	if (gearExists5==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension5-handThickness,
		notch_width=		handWidth5,
		sleeve_level=		sleeveLevel5,
		pin_radius=			(sleeveExtension5==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction5,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion4,
		small_gear_circular_pitch=	circular_pitch4-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel5,
		pin_radius=				(sleeveExtension5==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension5,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction5,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}

module pinion6(negativeSpace=false)
{
	if (gearExists6==2)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension6-handThickness,
		notch_width=		handWidth6,
		sleeve_level=		sleeveLevel6,
		pin_radius=			(sleeveExtension6==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction6,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio6)*pinion6,
		large_gear_circular_pitch=	circular_pitch6-trimCircularPitch,
		small_gear_teeth=		pinion5,
		small_gear_circular_pitch=	circular_pitch5-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel6,
		pin_radius=				(sleeveExtension6==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension6,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction6,
		negative_space=			negativeSpace,
		space=				negativeMargin);

	if (gearExists6==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension6-handThickness,
		notch_width=		handWidth6,
		sleeve_level=		sleeveLevel6,
		pin_radius=			(sleeveExtension6==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction6,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion5,
		small_gear_circular_pitch=	circular_pitch5-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel6,
		pin_radius=				(sleeveExtension6==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension6,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction6,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}

module pinion7(negativeSpace=false)
{
	if (gearExists7==2)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension7-handThickness,
		notch_width=		handWidth7,
		sleeve_level=		sleeveLevel7,
		pin_radius=			(sleeveExtension7==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction7,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio7)*pinion7,
		large_gear_circular_pitch=	circular_pitch7-trimCircularPitch,
		small_gear_teeth=		pinion6,
		small_gear_circular_pitch=	circular_pitch6-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel7,
		pin_radius=				(sleeveExtension7==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension7,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction7,
		negative_space=			negativeSpace,
		space=				negativeMargin);

	if (gearExists7==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension7-handThickness,
		notch_width=		handWidth7,
		sleeve_level=		sleeveLevel7,
		pin_radius=			(sleeveExtension7==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction7,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion6,
		small_gear_circular_pitch=	circular_pitch6-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel7,
		pin_radius=				(sleeveExtension7==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension7,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction7,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}

module pinion8(negativeSpace=false)
{
	if (gearExists8==2)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension8-handThickness,
		notch_width=		handWidth8,
		sleeve_level=		sleeveLevel8,
		pin_radius=			(sleeveExtension8==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction8,
		negative_space=		negativeSpace)
	pinionWheel(
		large_gear_teeth=		abs(ratio8)*pinion8,
		large_gear_circular_pitch=	circular_pitch8-trimCircularPitch,
		small_gear_teeth=		pinion7,
		small_gear_circular_pitch=	circular_pitch7-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel8,
		pin_radius=				(sleeveExtension8==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension8,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction8,
		negative_space=			negativeSpace,
		space=				negativeMargin);

	if (gearExists8==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension8-handThickness,
		notch_width=		handWidth8,
		sleeve_level=		sleeveLevel8,
		pin_radius=			(sleeveExtension8==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction8,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion7,
		small_gear_circular_pitch=	circular_pitch7-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel8,
		pin_radius=				(sleeveExtension8==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension8,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction8,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}


module pinion9(negativeSpace=false)
{
	if (gearExists9==3)
	handNotch(
		notch_height=		pinionThickness+sleeveExtension9-handThickness,
		notch_width=		handWidth9,
		sleeve_level=		sleeveLevel9,
		pin_radius=			(sleeveExtension9==0 ? bearingRadius : pinRadius),
		sleeve_thickness=		sleeveThickness,
		notch_angle=		correction9,
		negative_space=		negativeSpace)
	pinionEscapementWheel(
		radius=				escapement_radius,
		escapement_teeth=		numberTeeth,
		tooth_length=			toothLength, 
		tooth_lean=			toothLean,
		tooth_sharpness=			toothSharpness,
		small_gear_teeth=		pinion8,
		small_gear_circular_pitch=	circular_pitch8-trimCircularPitch,
		gear_clearance=			gearClearance,
		gear_backlash=			gearBacklash,
		gear_spacer=			gearSpacer,
		pressure_angle=			pressureAngle,
		twist_factor=			twistFactor,
		rim_width=				rimWidth,
		sleeve_level=			sleeveLevel9,
		pin_radius=				(sleeveExtension9==0 ? bearingRadius : pinRadius),
		sleeve_thickness=			sleeveThickness,
		loose_fit=				clearance,
		gear_thickness=			thickness,
		sleeve_extension=		sleeveExtension9,
		spacer=				spacer, 
		number_spokes=		numberSpokes,
		spoke_width=			spokeWidth,
		notch_angle=			correction9,
		negative_space=			negativeSpace,
		space=				negativeMargin, 
		clubSize=				clubSize,
		clubAngle=				clubAngle);
}

module escapementPendulum(sleeve_level,sleeve_extension,spacer,negativeSpace=false)
{
	pin_radius=(sleeve_extension==0 ? bearingRadius : pinRadius);
	bore_radius=pin_radius+sleeve_level*sleeveThickness+clearance;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeveThickness;

	union()
	{
		rotate(90-pendulumKink,[0,0,1])
		{
			translate([bore_radius,-armWidth,0])
			cube([pendulumLength-(bore_radius)-(snapFitHeight+tightFit),2*armWidth,hubHeight]);

			translate([pendulumLength,0,hubHeight/2])
			{
				translate([-pendulumRadius,-pendulumRadius,-hubHeight/2])
				cube([pendulumRadius,pendulumRadius*2,hubHeight]);
			}
		}

		if(negativeSpace==false) {ring(sleeve_radius,bore_radius,thickness+sleeve_extension+spacer);}

		if(negativeSpace==true) {translate([0,0,-negativeMargin])ring(sleeve_radius+negativeMargin,0,thickness+sleeve_extension+spacer+2*negativeMargin);}

		escapement(
			escapement_radius,
			thickness,
			faceAngle,
			armAngle,
			armWidth,
			numberTeeth,
			toothSpan,
			hubWidth,
			hubHeight,
			bore_radius,
			negativeSpace,
			negativeMargin,
			maxSwing,
			entryPalletAngle=45-toothLean+clubAngle, 
			exitPalletAngle=45-toothLean+clubAngle);
	}
}

module assembled(showShafts=false,showFrame=false,negativeSpace=false)
{
	union()
	{
		if(showFrame==true) 
		{
			frontFrame();

			backFrame();

			midFrame();
		}

		if (showShafts==true)
		{
			translate([0,0,-shaftLength+printLimit/4])
			placeWheel(fold_angle,axis_separation,0)
			{
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
				ring(pinRadius,0,shaftLength+printLimit/2);
			}
		}

		placeWheel(fold_angle,axis_separation,-deltaZ-explodeZ)
		{
			// pinion #1
			rotate([0,0,rotation_angle1-fold_angle1])
			{
				if (handWidth1!=0)
				rotate(correction1,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension1-handThickness+(1+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength1,
					hand_width=		handWidth1,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel1,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion1(negativeSpace);

				if (gearExists1==-2)
				translate([0,0,thickness+0.05+0.5*explodeZ])
				ratchet1(negativeSpace);
			}
		
			// pinion #2
			rotate([0,0,rotation_angle2-fold_angle2])
			{
				if (handWidth2!=0)
				rotate(correction2,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension2-handThickness+(2+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength2,
					hand_width=		handWidth2,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel2,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion2(negativeSpace);
			}

			//pinion #3
			rotate([0,0,rotation_angle3-fold_angle3])
			{
				if (handWidth3!=0)
				rotate(correction3,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension3-handThickness+(3+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength3,
					hand_width=		handWidth3,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel3,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion3(negativeSpace);

				if (gearExists3==4)
				rotate(pendulumCorrection-(rotation_angle3-fold_angle3),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel3,sleeveExtension3,spacer,negativeSpace);
			}
	
			//pinion #4
			rotate([0,0,rotation_angle4-fold_angle4])
			{
				if (handWidth4!=0)
				rotate(correction4,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension4-handThickness+(4+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength4,
					hand_width=		handWidth4,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel4,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion4(negativeSpace);

				if (gearExists4==4)
				rotate(pendulumCorrection-(rotation_angle4-fold_angle4),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel4,sleeveExtension4,spacer,negativeSpace);
			}
				
			// pinion #5
			rotate([0,0,rotation_angle5-fold_angle5])
			{
				if (handWidth5!=0)
				rotate(correction5,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension5-handThickness+(5+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength5,
					hand_width=		handWidth5,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel5,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion5(negativeSpace);

				if (gearExists5==4)
				rotate(pendulumCorrection-(rotation_angle5-fold_angle5),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel5,sleeveExtension5,spacer,negativeSpace);
			}
	
			//pinion #6
			rotate([0,0,rotation_angle6-fold_angle6])
			{
				if (handWidth6!=0)
				rotate(correction6,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension6-handThickness+(6+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength6,
					hand_width=		handWidth6,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel6,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion6(negativeSpace);

				if (gearExists6==4)
				rotate(pendulumCorrection-(rotation_angle6-fold_angle6),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel6,sleeveExtension6,spacer,negativeSpace);
			}

			//pinion #7
			rotate([0,0,rotation_angle7-fold_angle7])
			{
				if (handWidth7!=0)
				rotate(correction7,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension7-handThickness+(7+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength7,
					hand_width=		handWidth7,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel7,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion7(negativeSpace);

				if (gearExists7==4)
				rotate(pendulumCorrection-(rotation_angle7-fold_angle7),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel7,sleeveExtension7,spacer,negativeSpace);
			}
	
			//pinion #8
			rotate([0,0,rotation_angle8-fold_angle8])
			{
				if (handWidth8!=0)
				rotate(correction8,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension8-handThickness+(8+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength8,
					hand_width=		handWidth8,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel8,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion8(negativeSpace);

				if (gearExists8==4)
				rotate(pendulumCorrection-(rotation_angle8-fold_angle8),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel8,sleeveExtension8,spacer,negativeSpace);
			}
									
			//pinion#9
			rotate([0,0,rotation_angle9-fold_angle9])
			{	
				if (handWidth9!=0)
				rotate(correction9,[0,0,1])
				translate([0,0,pinionThickness+sleeveExtension9-handThickness+(9+1)*explodeZ])
				color([0,1,0])
				hand(
					hand_length=		handLength9,
					hand_width=		handWidth9,
					hand_thickness=		handThickness,
					sleeve_level=		sleeveLevel9,
					pin_radius=			pinRadius,
					sleeve_thickness=		sleeveThickness,
					loose_fit=			clearance,
					tight_fit=			tightFit,
					negative_space=		negativeSpace,
					space=			negativeMargin);
	
				pinion9(negativeSpace);

				if (gearExists9==4)
				rotate(pendulumCorrection-(rotation_angle9-fold_angle9),[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel9,sleeveExtension9,spacer,negativeSpace);
			}

			//pinion #10
			rotate([0,0,0])
			{
				if (gearExists10==4)
				rotate(pendulumCorrection,[0,0,1])
				translate([0,0,deltaZ+explodeZ])
				escapementPendulum(sleeveLevel10,sleeveExtension10,spacer,negativeSpace);
			}
		}
	}
}

module showPrintLimit(limit)
{
	translate([0,0,thickness/2])
	difference()
	{
		cube([limit,limit,thickness],true);
		translate([0,0,-1])
		cube([limit-clearance,limit-clearance,thickness+4],true);
	}

	translate([0,0,limit-thickness/2])
	difference()
	{
		cube([limit,limit,thickness],true);
		translate([0,0,-1])
		cube([limit-clearance,limit-clearance,thickness+4],true);
	}

}

module laidOutToPrint(index,show_limits=false,negativeSpace=false)
{
	if (show_limits)
	{
		showPrintLimit(printLimit);
		showPrintLimit(extremeLimit);
	}

	if (index == -1)
	{
		if (gearExists1!=1)
		{
			echo("This part is not needed!");	
		}

		if (gearExists1==1)
		{
			echo("Printing ratchet drum!");	
			ratchet1(negativeSpace);
		}
	}

	if (index == -2)
	{
		if (gearExists2!=1)
		{
			echo("This part is not needed!");	
		}

		if (gearExists2==1)
		{
			echo("Printing ratchet drum!");	
			ratchet2(negativeSpace);
		}
	}

	handPrintSpacing=printLimit/4;
	handPrintOffset=-printLimit/10;

	if (index == 0)
	{
		echo("Printing hands!");

		if (handWidth1!=0)
		translate([-printLimit/3,handPrintOffset+2*handPrintSpacing,0])
		hand(
			hand_length=		handLength1,
			hand_width=		handWidth1,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel1,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth2!=0)
		translate([printLimit/3,handPrintOffset+1.5*handPrintSpacing,0])
		rotate(180,[0,0,1])
		hand(
			hand_length=		handLength2,
			hand_width=		handWidth2,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel2,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth3!=0)
		translate([-printLimit/3,handPrintOffset+1*handPrintSpacing,0])
		hand(
			hand_length=		handLength3,
			hand_width=		handWidth3,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel3,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth4!=0)
		translate([printLimit/3,handPrintOffset+0.5*handPrintSpacing,0])
		rotate(180,[0,0,1])
		hand(
			hand_length=		handLength4,
			hand_width=		handWidth4,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel4,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth5!=0)
		translate([-printLimit/3,handPrintOffset+0*handPrintSpacing,0])
		hand(
			hand_length=		handLength5,
			hand_width=		handWidth5,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel5,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth6!=0)
		translate([printLimit/3,handPrintOffset-0.5*handPrintSpacing,0])
		rotate(180,[0,0,1])
		hand(
			hand_length=		handLength6,
			hand_width=		handWidth6,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel6,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth7!=0)
		translate([-printLimit/3,handPrintOffset-1.0*handPrintSpacing,0])
		hand(
			hand_length=		handLength7,
			hand_width=		handWidth7,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel7,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);

		if (handWidth8!=0)
		translate([printLimit/3,handPrintOffset-1.5*handPrintSpacing,0])
		rotate(180,[0,0,1])
		hand(
			hand_length=		handLength8,
			hand_width=		handWidth8,
			hand_thickness=		handThickness,
			sleeve_level=		sleeveLevel8,
			pin_radius=			pinRadius,
			sleeve_thickness=		sleeveThickness,
			loose_fit=			clearance,
			tight_fit=			tightFit,
			negative_space=		negativeSpace,
			space=			negativeMargin);
	}

	if (index == 1)
	{
		echo("Printing pinion 1!");	
		pinion1(negativeSpace);
	}

	if (index == 2)
	{
		echo("Printing pinion 2!");
		pinion2(negativeSpace);
	}

	if (index == 3)
	{
		echo("Printing pinion 3!");
		pinion3(negativeSpace);
	}


	if (index == 4)
	{
		echo("Printing pinion 4!");
		pinion4(negativeSpace);
	}

	if (index == 5)
	{
		echo("Printing pinion 5!");
		pinion5(negativeSpace);
	}

	if (index == 6)
	{
		echo("Printing pinion 6!");
		pinion6(negativeSpace);
	}

	if (index == 7)
	{
		echo("Printing pinion 7!");
		pinion7(negativeSpace);
	}

	if (index == 8)
	{
		echo("Printing pinion 8!");
		pinion8(negativeSpace);
	}

	if (index == 9)
	{
		echo("Printing pinion 9!");
		pinion9(negativeSpace);
	}


	if (index == 10)
	{
		echo("Printing escapement!");

		escapementPendulum(sleeveLevel10,sleeveExtension10,spacer,negativeSpace);
	}

	if (index == 11)
	{
		echo("Printing front frame!");

		frontFrame();
	}

	if (index == 12)
	{
		echo("Printing backframe!");

		backFrame();
	}
}

// Script

echo("Axis Separation:",axis_separation);

if (showAssembly==true) rotate (90,[1,0,0]) rotate (clockCorrection,[0,0,1]) assembled(showShafts,showFrame,showNegativeSpace);

if (showToPrint==true) laidOutToPrint(partToPrint,showLimits,showNegativeSpace); // there are 13 parts, numbers 0 thru 12 (-1 is the negative space of the whole clock, minus frame)

