/* The Printable Clock Project by Syvwlch, 
with help from MakerBlock, rustedrobot, barrychuck, 
and many others at Thingiverse. 

This script calls upon the ClockBuilder script to build a clock defined by the parameters below.

This is a complete, 6-gear clock with hour and minute hands.

CC-A-SA licensed.*/

// Overall Parameters
	scale=1;				// scaling factor for the whole model
	printLimit=80*scale; 		// diameter of the largest circle that can be printed on the 'bot 
	extremeLimit=100*scale; 	// dimension of the theoretical print area, only used for visualization
	thickness=6*scale; 		// thickness along the Z axis 
	spacer=1*scale;		 	// space between gears in a wheel along z axis

	drumHeight=3*thickness; 	// height of the drum (along z), only for drum pinion
	ratchetAdjust=20; 		// needs to be adjusted based on number of spokes (e.g. 20 for 5 spokes)

	boltHeadRadius=3*scale; 	// radius for the counter-sunk holes in the frame for bolt heads
	boltHeadThickness=3*scale;	// thickness for the counter-sunk holes in the frame for bolt heads

// Command Parameters
	showAssembly=	true;		// true to show the whole clock, assembled
	showToPrint=	false;		// true to show only one part, laid out for printing

	showLimits=		false;		// in laid out to print mode, show the print volume limits
	partToPrint=	12;		// in laid out to print mode, which part to show

	showShafts=	false;		// whether to show the metal shafts in assembled clock
	showFrame=	true;		// whether to show the frame in assembled clock
	explodeZ=		0*scale;	// exploded view parameter for assembled clock

	showNegativeSpace=false;	// whether to show the negative space version of the parts
	negativeMargin=	0*scale;	// margin around the negative space version of the parts

// Clock parameters

	fold_angle=180;			// how much the gear train folds on itself at each gear, in degrees 
	clockCorrection=90;		// correction angle for the whole clock
	
	twistFactor=0.3;			// how many teeth-widths of the pinions to twist the herringbone gears by
						// 0 means no herringbone gears at all

	// primary rotation of the slowest wheel, usually the hours' hand 
		rotation_angle= -(3600*1+60*50+31)/120;

	gearExists1=	-2;		// 1:drum, -2: ratcheting drum
	gearExists2=	2;		// 2:pinion gear, 3: escapement wheel
	gearExists3=	2;		// 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists4=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists5=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists6=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists7=	3;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists8=	4;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists9=	0;		// 0: none, 3: escapement wheel, 4:escapement
	gearExists10=	0;		// 4:escapement

	ratio1=		-4; 			// 4 
	ratio2=		-3; 			// 12
	ratio3=		-3.199999; 			// 3.2
	ratio4=		-3;			// 9.6
	ratio5=		-2.5; 			// 24
	ratio6=		-2.5; 			// 60
	ratio7=		-1; 			// 
	ratio8=		-1; 			// 
	
	pinion1=		8; 			// ratioN times pinionN must be an integer! 
	pinion2=		10; 			// ratioN times pinionN must be an integer!
	pinion3=		10; 			// ratioN times pinionN must be an integer!
	pinion4=		10; 			// ratioN times pinionN must be an integer!
	pinion5=		12; 			// ratioN times pinionN must be an integer!
	pinion6=		12; 			// ratioN times pinionN must be an integer!
	pinion7=		10; 			// ratioN times pinionN must be an integer!
	pinion8=		10; 			// ratioN times pinionN must be an integer!

// Hand Parameters 
	handThickness=	0.5*thickness; 		// thickness of the hands (and extension of the sleeves past the next outer sleeve)
	secondLength=	0.5*printLimit; 		// length of the seconds hand
	secondWidth=	0.5*handThickness; 	// width of the seconds hand
	minuteLength=	1*secondLength; 	// length of the minutes hand
	minuteWidth=	1*secondWidth; 		// width of the minutes hand
	hourLength=	0.7*secondLength; 	// legnth of the hours hand
	hourWidth=		2*secondWidth; 		// width of the hours hand

	handWidth1=	hourWidth;		//
	handWidth2=	0;			//
	handWidth3=	minuteWidth;	//
	handWidth4=	0;			//
	handWidth5=	0;			//
	handWidth6=	0;			//
	handWidth7=	0;			//
	handWidth8=	0;			//
	handWidth9=	0;			//

	handLength1=	hourLength;		//
	handLength2=	0;			//
	handLength3=	minuteLength;	//
	handLength4=	0;			//
	handLength5=	0;			//
	handLength6=	0;			//
	handLength7=	0;			//
	handLength8=	0;			//
	handLength9=	0;			//

	sleeveLevel1=	1; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft) 
	sleeveLevel2=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel3=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel4=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel5=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel6=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel7=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel8=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel9=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel10=	0;			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)

// Preliminary Calcs 

	// distance between consecutive gear shafts 
		axis_separation= 0.5*printLimit*4/3.2; // driven by the ratio of the largest, and next-largest, gear ratio
	
	// distance between shaft for escapement and wheel
		escapement_separation= axis_separation;
	
	// thickness of the drum gear, without extension
		drumThickness= drumHeight+thickness;
	
	// thickness of a pinion gear, without extension
		pinionThickness= 2*thickness+spacer;
	
	// thickness of the escapement wheel, without extension
		escapementWheelThickness= 2*thickness+spacer;
	
	// add'l thickness per hand
		addHandThickness= handThickness+spacer;
	
	// add'l thickness for frame
		addFrameThickness= thickness+spacer;
	
	// deltaZ per gear in chain
		deltaZ= thickness+spacer;

	// height of sleeve extensions above body of gear wheels or escapement
		sleeveExtension1=	addFrameThickness+addHandThickness-spacer+1;
		sleeveExtension2=	0;
		sleeveExtension3=	drumThickness+addFrameThickness+2*addHandThickness+0*deltaZ+1;
		sleeveExtension4=	0;
		sleeveExtension5=	0;
		sleeveExtension6=	0;
		sleeveExtension7=	0;
		sleeveExtension8=	spacer-0.5;
		sleeveExtension9=	0;
		sleeveExtension10=	sleeveExtension8;

	// overall length of the shaft indicators (these don't get printed)
		shaftLength=		drumThickness+addFrameThickness+2*addHandThickness+7*deltaZ+7*explodeZ;

	// bend in the pendulum ensuring it points down
		pendulumKink=		90+clockCorrection+7*fold_angle;

include <ClockBuilderScript.scad>

// custom dev goes after this comment 

module boltHole(boltHeadRadius,boltHeadThickness,headSegments=6)
{
	union()
	{
		ring(
			pinRadius+clearance,
			0,
			addFrameThickness,
			30,
			5);
		ring(
			pinRadius,
			0,
			addFrameThickness+drumHeight+thickness+2*deltaZ+0.5+addFrameThickness+4*deltaZ+0.5,
			30,
			5);
	}
}

module frontFrame() 
{
	bore_radius=pinRadius+clearance;
	sleeve_radius=pinRadius+sleeveThickness*2;
	bore_radius1=(sleeveLevel1==0 ? bore_radius : bore_radius+(sleeveLevel1+1)*sleeveThickness);
	sleeve_radius1=sleeve_radius+(sleeveLevel1+1)*sleeveThickness;
	
	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate(
		[(showToPrint==true ? axis_separation/2 : 0),
		0,
		(showAssembly==true ? 1*thickness+drumHeight+spacer+0.5+explodeZ : 0)])
	{
		rotate((showAssembly==true ? 180 : 0),[1,0,0])
		translate([0,0,(showAssembly==true ? -thickness : 0)])
		union()
		placeWheel(fold_angle,axis_separation,0)
		{
			rotate(180,[0,0,1])
			{
				ring(sleeve_radius1,bore_radius1,addFrameThickness);

				translate([bore_radius1,-sleeve_radius/2,0])
				cube([axis_separation-(bore_radius+bore_radius1),sleeve_radius,thickness]);

				rotate(-60,[0,0,1])
				translate([bore_radius1,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius1,sleeve_radius,thickness]);

				rotate(-60,[0,0,1])
				translate([axis_separation,0,0])
				rotate(60,[0,0,1])
				translate([0,-sleeve_radius,0])
				ring(sleeve_radius,pinRadius,addFrameThickness+drumHeight+thickness+2*deltaZ+0.5);

				rotate(60,[0,0,1])
				translate([bore_radius1,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius1,sleeve_radius,thickness]);
			}
		
			rotate(180,[0,0,1])
			{
				ring(sleeve_radius,pinRadius,addFrameThickness+drumHeight);

				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-(bore_radius+bore_radius1),sleeve_radius,thickness]);

				rotate(-60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius,sleeve_radius,thickness]);

				rotate(-60,[0,0,1])
				translate([axis_separation,0,0])
				rotate(60,[0,0,1])
				translate([0,-sleeve_radius,0])
				ring(sleeve_radius,pinRadius,addFrameThickness+drumHeight+thickness+2*deltaZ+0.5);

				rotate(60,[0,0,1])
				translate([sleeveLevel1*sleeveThickness,-sleeve_radius/2,0])
				cube([axis_separation-(sleeveLevel1*sleeveThickness),sleeve_radius,thickness]);
			}
		}
	}
}

module backFrame()
{
	bore_radius=pinRadius+clearance;
	sleeve_radius=pinRadius+sleeveThickness*2;

	color([0.5,1,0.5])
	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate(
		[(showToPrint==true ? axis_separation/2 : 0),
		0,
		(showAssembly==true ? -addFrameThickness-0.5-6*deltaZ-7*explodeZ : 0)])
	union()
	placeWheel(fold_angle,axis_separation,0)
	{
		rotate(180,[0,0,1])
		{
			union()
			{
				ring(sleeve_radius,bore_radius,addFrameThickness);

				boltHole(boltHeadRadius,boltHeadThickness);
			}

			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);

			rotate(-60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-boltHeadRadius,sleeve_radius,thickness]);
			
			rotate(-60,[0,0,1])
			translate([axis_separation,0,0])
			rotate(60,[0,0,1])
			translate([0,-sleeve_radius,0])
			union()
			{
				ring(sleeve_radius,bore_radius,addFrameThickness+4*deltaZ+0.5);

				boltHole(boltHeadRadius,boltHeadThickness);
			}

			rotate(60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-boltHeadRadius,sleeve_radius,thickness]);

			rotate(-60,[0,0,1])
			translate([axis_separation-3*boltHeadRadius,-(sleeve_radius/2+boltHeadRadius),0]) 
			difference()
			{
				ring(sleeve_radius,bore_radius,thickness);

				mirror([0,0,1])
				translate([0,0,-thickness])
				boltHole(boltHeadRadius,boltHeadThickness,30);
			}
			
			rotate(60,[0,0,1])
			translate([axis_separation-3*boltHeadRadius,(sleeve_radius/2+boltHeadRadius),0]) 
			difference()
			{
				ring(sleeve_radius,bore_radius,thickness);

				mirror([0,0,1])
				translate([0,0,-thickness])
				boltHole(boltHeadRadius,boltHeadThickness,30);
			}
		}

		rotate(180,[0,0,1])
		{
			union()
			{
				ring(sleeve_radius,bore_radius,addFrameThickness);

				boltHole(boltHeadRadius,boltHeadThickness);
			}

			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);

			rotate(-60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-boltHeadRadius,sleeve_radius,thickness]);
			
			rotate(-60,[0,0,1])
			translate([axis_separation,0,0])
			rotate(60,[0,0,1])
			translate([0,-sleeve_radius,0])
			union()
			{
				ring(sleeve_radius,bore_radius,addFrameThickness+4*deltaZ+0.5);

				boltHole(boltHeadRadius,boltHeadThickness);
			}

			rotate(60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-boltHeadRadius,sleeve_radius,thickness]);
			
			rotate(-60,[0,0,1])
			translate([axis_separation-3*boltHeadRadius,-(sleeve_radius/2+boltHeadRadius),0]) 
			difference()
			{
				ring(sleeve_radius,bore_radius,thickness);

				mirror([0,0,1])
				translate([0,0,-thickness])
				boltHole(boltHeadRadius,boltHeadThickness,30);
			}
			
			rotate(60,[0,0,1])
			translate([axis_separation-3*boltHeadRadius,(sleeve_radius/2+boltHeadRadius),0]) 
			difference()
			{
				ring(sleeve_radius,bore_radius,thickness);

				mirror([0,0,1])
				translate([0,0,-thickness])
				boltHole(boltHeadRadius,boltHeadThickness,30);
			}
		}
	}
}

module midFrame()
{
}