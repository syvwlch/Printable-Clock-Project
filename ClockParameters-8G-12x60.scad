/* The Printable Clock Project by Syvwlch, 
with help from MakerBlock, rustedrobot, barrychuck, 
and many others at Thingiverse. 

This script calls upon the ClockBuilder script to build a clock defined by the parameters below.

This is a complete, 8-gear clock with hour, minute and second hands.

CC-A-SA licensed.*/

// Overall Parameters
	scale=1;				// scaling factor for the whole model
	printLimit=80*scale; 		// diameter of the largest circle that can be printed on the 'bot 
	extremeLimit=100*scale; 	// dimension of the theoretical print area, only used for visualization
	thickness=6*scale; 		// thickness along the Z axis 
	spacer=1*scale;		 	// space between gears in a wheel along z axis

	drumHeight=3*thickness; 	// height of the drum (along z), only for drum pinion
	ratchetAdjust=30; 		// needs to be adjusted based on number of spokes (e.g. 20 for 5 spokes)

// Command Parameters
	showAssembly=	false;		// true to show the whole clock, assembled
	showToPrint=	true;		// true to show only one part, laid out for printing

	showLimits=		false;		// in laid out to print mode, show the print volume limits
	partToPrint=	-2;		// in laid out to print mode, which part to show

	showShafts=	true;		// whether to show the metal shafts in assembled clock
	showFrame=	true;		// whether to show the frame in assembled clock
	explodeZ=		0*scale;	// exploded view parameter for assembled clock

	showNegativeSpace=false;	// whether to show the negative space version of the parts
	negativeMargin=	0*scale;	// margin around the negative space version of the parts

// Clock parameters

	fold_angle=90;			// how much the gear train folds on itself at each gear, in degrees 
	clockCorrection=-135;		// correction angle for the whole clock
	
	twistFactor=0.3;			// how many teeth-widths of the pinions to twist the herringbone gears by
						// 0 means no herringbone gears at all

	// primary rotation of the slowest wheel, usually the hours' hand 
		rotation_angle=0;// -(3600*1+60*50+30)/120;

	gearExists1=	-2;		// 1:drum, -2: ratcheting drum
	gearExists2=	2;		// 2:pinion gear, 3: escapement wheel
	gearExists3=	2;		// 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists4=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists5=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists6=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists7=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists8=	2;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists9=	3;		// 0: none, 3: escapement wheel, 4:escapement
	gearExists10=	4;		// 4:escapement

	ratio1=		-2; 			// 2 
	ratio2=		-2; 			// 4
	ratio3=		-2; 			// 8
	ratio4=		-1.5;			// 12
	ratio5=		-3.2; 			// 3.2
	ratio6=		-3; 			// 9.6
	ratio7=		-2.5; 			// 24
	ratio8=		-2.5; 			// 60
	
	pinion1=		12; 			// ratioN times pinionN must be an integer! 
	pinion2=		12; 			// ratioN times pinionN must be an integer!
	pinion3=		12; 			// ratioN times pinionN must be an integer!
	pinion4=		16; 			// ratioN times pinionN must be an integer!
	pinion5=		10; 			// ratioN times pinionN must be an integer!
	pinion6=		8; 			// ratioN times pinionN must be an integer!
	pinion7=		10; 			// ratioN times pinionN must be an integer!
	pinion8=		10; 			// ratioN times pinionN must be an integer!

// Hand Parameters 
	handThickness=	0.5*thickness; 		// thickness of the hands (and extension of the sleeves past the next outer sleeve)
	secondLength=	0.4*printLimit; 		// length of the seconds hand
	secondWidth=	0.5*handThickness; 	// width of the seconds hand
	minuteLength=	0.8*secondLength; 	// length of the minutes hand
	minuteWidth=	1*secondWidth; 		// width of the minutes hand
	hourLength=	0.6*secondLength; 	// legnth of the hours hand
	hourWidth=		2*secondWidth; 		// width of the hours hand

	handWidth1=	hourWidth;		//
	handWidth2=	0;			//
	handWidth3=	0;			//
	handWidth4=	0;			//
	handWidth5=	minuteWidth;	//
	handWidth6=	0;			//
	handWidth7=	0;			//
	handWidth8=	0;			//
	handWidth9=	secondWidth;	//

	handLength1=	hourLength;		//
	handLength2=	0;			//
	handLength3=	0;			//
	handLength4=	0;			//
	handLength5=	minuteLength;	//
	handLength6=	0;			//
	handLength7=	0;			//
	handLength8=	0;			//
	handLength9=	secondLength;	//

	sleeveLevel1=	2; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft) 
	sleeveLevel2=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel3=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel4=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel5=	1; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel6=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel7=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel8=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel9=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)
	sleeveLevel10=	0;			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft)

// Preliminary Calcs 

	// distance between consecutive gear shafts 
		axis_separation= 0.5*printLimit*3.2/3; // driven by the ratio of the largest, and next-largest, gear ratio
	
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
		sleeveExtension1=	addFrameThickness+addHandThickness-spacer;
		sleeveExtension2=	0;
		sleeveExtension3=	0;
		sleeveExtension4=	0;
		sleeveExtension5=	drumThickness+addFrameThickness+2*addHandThickness+2*deltaZ;
		sleeveExtension6=	0;
		sleeveExtension7=	0;
		sleeveExtension8=	0;
		sleeveExtension9=	drumThickness+addFrameThickness+3*addHandThickness+6*deltaZ;
		sleeveExtension10=	0;

	// overall length of the shaft indicators (these don't get printed)
		shaftLength=		drumThickness+addFrameThickness+3*addHandThickness+9*deltaZ;

	// bend in the pendulum ensuring it points down
		pendulumKink=		90+clockCorrection+9*fold_angle;

include <ClockBuilderScript.scad>

// custom dev goes after this comment 


module frontFrame()
{
	bore_radius=pinRadius+clearance; 
	sleeve_radius=pinRadius+sleeveThickness*2;

	bore_radius1=pinRadius+sleeveThickness*(sleeveLevel1+1)+clearance;
	sleeve_radius1=pinRadius+sleeveThickness*(sleeveLevel1+2);

	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate([(showToPrint==true ? printLimit/4 : 0),(showToPrint==true ? printLimit/4 : 0),(showAssembly==true ? 2*thickness+spacer+0.5 : 0)])
	{
		rotate((showAssembly==true ? 180 : 0),[1,0,0])
		translate([0,0,(showAssembly==true ? -thickness : 0)])
		placeWheel(-fold_angle,axis_separation,0)
		{
			rotate(-90,[0,0,1])
			{
				ring(sleeve_radius1,bore_radius1,addFrameThickness);
	
				translate([bore_radius1,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);
	
				rotate(60,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,thickness+0.5);
	
				rotate(60,[0,0,1])
				translate([bore_radius1,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);
	
				rotate(-150,[0,0,1])
				translate([bore_radius1,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);
			}
	
			rotate(-90,[0,0,1])
			{
				ring(sleeve_radius,bore_radius,addFrameThickness+thickness+spacer);
	
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
	
				rotate(60,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,deltaZ+thickness+0.5);
	
				rotate(60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
	
				rotate(-150,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
			}

			rotate(-90,[0,0,1])
			{
				ring(sleeve_radius,bore_radius,addFrameThickness+2*(thickness+spacer));

				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

				rotate(60,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,2*deltaZ+thickness+0.5);

				rotate(60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

				rotate(-150,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
			}
			rotate(-90,[0,0,1])
			{
				ring(sleeve_radius,bore_radius,addFrameThickness+3*(thickness+spacer));

				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);

				rotate(60,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,3*deltaZ+thickness+0.5);

				rotate(60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

				rotate(-150,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
			}
		}
	}
}

module backFrame()
{
	bore_radius=pinRadius+clearance; 
	sleeve_radius=pinRadius+sleeveThickness*2;

	bore_radius1=bore_radius;
	sleeve_radius1=sleeve_radius;

	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate([(showToPrint==true ? printLimit/4 : 0),(showToPrint==true ? -printLimit/4 : 0),(showAssembly==true ? -drumThickness-6*thickness-8*spacer-1 : 0)])
	placeWheel(fold_angle,axis_separation,0)
	{
		rotate(180,[0,0,1])
		{
			ring(sleeve_radius1,bore_radius1,thickness+spacer);

			translate([bore_radius1,-sleeve_radius/2,0])
			cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);

			rotate(60,[0,0,1])
			translate([axis_separation,0,0])
			ring(sleeve_radius,bore_radius,addFrameThickness+3*deltaZ-1);

			rotate(60,[0,0,1])
			translate([bore_radius1,-sleeve_radius/2,0])
			cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);

			rotate(-150,[0,0,1])
			translate([bore_radius1,-sleeve_radius/2,0])
			cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);
		}

		rotate(180,[0,0,1])
		{
			ring(sleeve_radius,bore_radius,thickness+spacer);

			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-bore_radius-bore_radius1,sleeve_radius,thickness]);

			rotate(60,[0,0,1])
			translate([axis_separation,0,0])
			ring(sleeve_radius,bore_radius,addFrameThickness+2*deltaZ-1);

			rotate(60,[0,0,1])
			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

			rotate(-150,[0,0,1])
			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		}

		rotate(180,[0,0,1])
		{
			ring(sleeve_radius,bore_radius,3*(thickness+spacer));

			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

			rotate(60,[0,0,1])
			translate([axis_separation,0,0])
			ring(sleeve_radius,bore_radius,addFrameThickness+1*deltaZ-1);

			rotate(60,[0,0,1])
			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

			rotate(-150,[0,0,1])
			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		}
		rotate(180,[0,0,1])
		{
			ring(sleeve_radius,bore_radius,2*(thickness+spacer));

			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

			rotate(60,[0,0,1])
			translate([axis_separation,0,0])
			ring(sleeve_radius,bore_radius,addFrameThickness+4*deltaZ-1);

			rotate(60,[0,0,1])
			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

			rotate(-150,[0,0,1])
			translate([bore_radius,-sleeve_radius/2,0])
			cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		}
	}
}

module midFramePart(sleeve_levelA=0,sleeve_levelB=0)
{
	bore_radius=pinRadius+clearance; 
	sleeve_radius=pinRadius+sleeveThickness*2;

	bore_radiusA=pinRadius+sleeveThickness*(sleeve_levelA)+clearance;
	sleeve_radiusA=pinRadius+sleeveThickness*(sleeve_levelA+1);

	bore_radiusB=pinRadius+sleeveThickness*(sleeve_levelB)+clearance;
	sleeve_radiusB=pinRadius+sleeveThickness*(sleeve_levelB+1);

	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate([(showToPrint==true ? printLimit/4 : 0),(showToPrint==true ? printLimit/4 : 0),(showAssembly==true ? 2*thickness+spacer+0.5 : 0)])
	{
		placeWheel(fold_angle,axis_separation,-deltaZ)
		{
			rotate(-90,[0,0,1])
			{
				ring(sleeve_radiusA,bore_radiusA,deltaZ);

				rotate(-fold_angle,[0,0,1])	
				translate([bore_radiusA,-sleeve_radiusA/2,0])
				cube([axis_separation-bore_radiusA-bore_radiusB,sleeve_radiusA,deltaZ-spacer]);
	
				rotate(-fold_angle,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radiusB,bore_radiusB,deltaZ);

				rotate(-30,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,addFrameThickness+3*deltaZ);

				rotate(-30,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);

				rotate(-fold_angle,[0,0,1])
				translate([axis_separation,0,0])
				rotate(120,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
			}
		}
	}
}

module midFrame()
{
	translate([(showToPrint==true ? printLimit/4 : 0),(showToPrint==true ? printLimit/4 : 0),(showAssembly==true ? -3*thickness-3*spacer-0.5 : 0)])
	placeWheel(fold_angle,axis_separation,-deltaZ)
	{
		cube(0);
	color([0,1,0])
		midFramePart(0,2);
	color([1,0,0])
		midFramePart(0,0);
	color([1,0,0])
		midFramePart(0,0);
	color([0,0,1])
		midFramePart(1,0);
	color([0,1,1])
		midFramePart(0,1);
	color([1,0,0])
		midFramePart(0,0);
	}
}