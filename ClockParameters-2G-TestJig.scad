/* The Printable Clock Project by Syvwlch, 
with help from MakerBlock, rustedrobot, barrychuck, 
and many others at Thingiverse. 

This script calls upon the ClockBuilder script to build a clock defined by the parameters below.

This clock is a simple jig aimed at testing the escapement. It does not include any hands, and the gear ratio is arbitrary.

CC-A-SA licensed.*/

// Overall Parameters
	scale=1;				// scaling factor for the whole model
	printLimit=80*scale; 		// diameter of the largest circle that can be printed on the 'bot 
	extremeLimit=100*scale; 	// dimension of the theoretical print area, only used for visualization
	thickness=6*scale; 		// thickness along the Z axis 
	spacer=thickness;		 	// space between gears in a wheel along z axis

	drumHeight=2*thickness; 	// height of the drum (along z), only for drum pinion

	boltHeadRadius=3*scale;	// radius for the counter-sunk holes in the frame for bolt heads

// Command Parameters
	showAssembly=	true;		// true to show the whole clock, assembled
	showToPrint=	false;		// true to show only one part, laid out for printing

	showLimits=		false;		// in laid out to print mode, show the print volume limits
	partToPrint=	12;		// in laid out to print mode, which part to show

	showShafts=	true;		// whether to show the metal shafts in assembled clock
	showFrame=	true;		// whether to show the frame in assembled clock
	explodeZ=		0*scale;	// exploded view parameter for assembled clock

	showNegativeSpace=false;	// whether to show the negative space version of the parts
	negativeMargin=	0*scale;	// margin around the negative space version of the parts

// Clock parameters

	fold_angle=180;			// how much the gear train folds on itself at each gear, in degrees 
	clockCorrection=-90;		// correction angle for the whole clock
	
	twistFactor=0.3;			// how many teeth-widths of the pinions to twist the herringbone gears by
						// 0 means no herringbone gears at all

	// primary rotation of the slowest wheel, usually the hours' hand 
	rotation_angle=-(3600*1+60*50+30)/120;

	gearExists1=	1;		// 1:drum
	gearExists2=	3;		// 2:pinion gear, 3: escapement wheel
	gearExists3=	4;		// 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists4=	0;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists5=	0;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists6=	0;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists7=	0;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists8=	0;		// 0: none, 2:pinion gear, 3: escapement wheel, 4:escapement
	gearExists9=	0;		// 0: none, 3: escapement wheel, 4:escapement
	gearExists10=	0;		// 4:escapement

	ratio1=		-4; 			// 4 
	ratio2=		-1; 			// 
	ratio3=		-1; 			// 
	ratio4=		-1;			// 
	ratio5=		-1; 			// 
	ratio6=		-1; 			// 
	ratio7=		-1; 			// 
	ratio8=		-1; 			// 
	
	pinion1=		8; 			// ratioN times pinionN must be an integer! 
	pinion2=		6; 			// ratioN times pinionN must be an integer!
	pinion3=		6; 			// ratioN times pinionN must be an integer!
	pinion4=		6; 			// ratioN times pinionN must be an integer!
	pinion5=		6; 			// ratioN times pinionN must be an integer!
	pinion6=		6; 			// ratioN times pinionN must be an integer!
	pinion7=		6; 			// ratioN times pinionN must be an integer!
	pinion8=		6; 			// ratioN times pinionN must be an integer!

// Hand Parameters 
	handThickness=	0.5*thickness; 		// thickness of the hands (and extension of the sleeves past the next outer sleeve)
	secondLength=	0.4*printLimit; 		// length of the seconds hand
	secondWidth=	0.5*handThickness; 	// width of the seconds hand
	minuteLength=	0.8*secondLength; 	// length of the minutes hand
	minuteWidth=	1*secondWidth; 		// width of the minutes hand
	hourLength=	0.6*secondLength; 	// legnth of the hours hand
	hourWidth=		2*secondWidth; 		// width of the hours hand

	handWidth1=	0;			//
	handWidth2=	0;			//
	handWidth3=	0;			//
	handWidth4=	0;			//
	handWidth5=	0;			//
	handWidth6=	0;			//
	handWidth7=	0;			//
	handWidth8=	0;			//
	handWidth9=	0;			//

	handLength1=	0;			//
	handLength2=	0;			//
	handLength3=	0;			//
	handLength4=	0;			//
	handLength5=	0;			//
	handLength6=	0;			//
	handLength7=	0;			//
	handLength8=	0;			//
	handLength9=	0;			//

	sleeveLevel1=	0; 			// total number of sleeve(s) the wheel must fit over (e.g. zero if directly on shaft) 
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
		addFrameThickness= spacer;
	
	// deltaZ per gear in chain
		deltaZ= thickness+spacer;

	// height of sleeve extensions above body of gear wheels or escapement
		sleeveExtension1=	0.5;
		sleeveExtension2=	0.5;
		sleeveExtension3=	thickness-0.5;
		sleeveExtension4=	0;
		sleeveExtension5=	0;
		sleeveExtension6=	0;
		sleeveExtension7=	0;
		sleeveExtension8=	0;
		sleeveExtension9=	0;
		sleeveExtension10=	sleeveExtension3;

	// overall length of the shaft indicators (these don't get printed)
		shaftLength=		drumThickness+addFrameThickness+1*addHandThickness+3*deltaZ;

	// bend in the pendulum ensuring it points down
		pendulumKink=		-90+clockCorrection+3*fold_angle;

include <ClockBuilderScript.scad>

// custom dev goes after this comment

module frontFrame()
{
	bore_radius=pinRadius+clearance;
	sleeve_radius=pinRadius+sleeveThickness*2;

	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate([(showToPrint==true ? printLimit/4 : 0),0,(showAssembly==true ? 2*thickness+spacer+0.5 : 0)])
	{
		rotate((showAssembly==true ? 180 : 0),[1,0,0])
		translate([0,0,(showAssembly==true ? -thickness : 0)])
		union()
		placeWheel(fold_angle,axis_separation,0)
		{
			rotate(180,[0,0,1])
			{
				ring(sleeve_radius,bore_radius,addFrameThickness);
		
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		
				rotate(-60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		
				rotate(-60,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,addFrameThickness+deltaZ+thickness+0.5);
		
				rotate(60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
			}
		
			rotate(180,[0,0,1])
			{
				ring(sleeve_radius,bore_radius,addFrameThickness+deltaZ);
		
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		
				rotate(-60,[0,0,1])
				translate([bore_radius,-sleeve_radius/2,0])
				cube([axis_separation-2*bore_radius,sleeve_radius,thickness]);
		
				rotate(-60,[0,0,1])
				translate([axis_separation,0,0])
				ring(sleeve_radius,bore_radius,addFrameThickness+deltaZ+thickness+0.5);
		
				rotate(60,[0,0,1])
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

	rotate((showToPrint==true ? 45 : 0),[0,0,1])
	translate([(showToPrint==true ? printLimit/4 : 0),0,(showAssembly==true ? -drumThickness-thickness-0.5 : 0)])
	union()
	placeWheel(fold_angle,axis_separation,0)
	{
		rotate(180,[0,0,1])
		{
			ring(sleeve_radius,boltHeadRadius,thickness,30,6);

			translate([0,0,thickness/2])
			difference()
			{
				cylinder(thickness/2,sleeve_radius,sleeve_radius,$fn=30); 
				translate([0,0,0])
				cylinder(thickness/2,boltHeadRadius,bore_radius,$fn=30);
			}

			translate([0,0,thickness])
			ring(sleeve_radius,bore_radius,addFrameThickness);
	
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);
	
			rotate(-60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);
	
			rotate(-60,[0,0,1])
			translate([axis_separation,0,0])
			ring(sleeve_radius,boltHeadRadius,thickness,30,6);

			rotate(-60,[0,0,1])
			translate([axis_separation,0,thickness/2])
			difference()
			{
				cylinder(thickness/2,sleeve_radius,sleeve_radius,$fn=30); 
				translate([0,0,0])
				cylinder(thickness/2,boltHeadRadius,bore_radius,$fn=30);
			}

			rotate(-60,[0,0,1])
			translate([axis_separation,0,thickness])
			ring(sleeve_radius,bore_radius,addFrameThickness+deltaZ+0.5);
	
			rotate(60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);
		}
	
		rotate(180,[0,0,1])
		{
			ring(sleeve_radius,boltHeadRadius,thickness,30,6);

			translate([0,0,thickness/2])
			difference()
			{
				cylinder(thickness/2,sleeve_radius,sleeve_radius,$fn=30); 
				translate([0,0,0])
				cylinder(thickness/2,boltHeadRadius,bore_radius,$fn=30);
			}

			translate([0,0,thickness])
			ring(sleeve_radius,bore_radius,addFrameThickness);
	
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);
	
			rotate(-60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);
	
			rotate(-60,[0,0,1])
			translate([axis_separation,0,0])
			ring(sleeve_radius,boltHeadRadius,thickness,30,6);

			rotate(-60,[0,0,1])
			translate([axis_separation,0,thickness/2])
			difference()
			{
				cylinder(thickness/2,sleeve_radius,sleeve_radius,$fn=30); 
				translate([0,0,0])
				cylinder(thickness/2,boltHeadRadius,bore_radius,$fn=30);
			}

			rotate(-60,[0,0,1])
			translate([axis_separation,0,thickness])
			ring(sleeve_radius,bore_radius,addFrameThickness+deltaZ+0.5);
	
			rotate(60,[0,0,1])
			translate([boltHeadRadius,-sleeve_radius/2,0])
			cube([axis_separation-2*boltHeadRadius,sleeve_radius,thickness]);

			rotate(-60,[0,0,1])
			translate([axis_separation-3*boltHeadRadius,-(sleeve_radius/2+bore_radius),0])			
			ring(sleeve_radius,bore_radius,thickness);

			rotate(60,[0,0,1])
			translate([axis_separation-3*boltHeadRadius,(sleeve_radius/2+bore_radius),0])			
			ring(sleeve_radius,bore_radius,thickness);
		}
	}
}

module midFrame()
{
}