/* 
This is an OpenSCAD library to create various pinion wheels, escapements and other pieces of clockwork gearing
Uses the MCAD involute_gears library and will not work without it!
Created by syvwlch and licensed under the Attribution - Share Alike - Creative Commons license.

v1 - 2011 04 15	
First library version of the code

v2 - 2011 04 21	
Added spokes() module, and used it in escapement() module
Updated escapement(), ringtooth(), tooth() and ring() modules to render better in openCSG mode

v3 - 2011 04 22
Renamed to clockworkLibrary
Added hand(), handNotch(), pinionWheel(), pinionEscapementWheel(), pinionDrum()

v4 - 2011 04 29
Added negative space toggle to the parts, with a default value of false

v5 - 2011 05 01
Added herringbone gear option, with a default value of 0
Strengthened pinion teeth.

v6 - 2011 05 04 
Changed how drum height in pinionDrum() is measured to work like sleeve extension does, to simplify placement math
Corrected error in how sleeve extension is measured in pinionWheel() (wheels are 2*thickness+1*spacer thick)
Changed how drum height in pinionEscapementWheel() is measured, to standardize
Create a drum() module, and implemeted flanges to keep the string from falling off
Retrofitted drum() into pinionDrum(), as well as for the spacer in pinionEscapementWheel() and pinionWheel()

v7 - 2011 05 04 
Added an assymetric spacer so that the herringbone gears would mesh without running into the drum flanges
Switched to using mirror() to implement the two halves of the herringbone as a result

v8 - 2011 05 06
Fixed a bug in spokes() which referenced the wrong spoke width parameter (thanks kitlaan!)

v9 - 2011 05 07
Modified the escapement wheel profile to support club teeth (still defaults to ratchet teeth)
Club tooth parameters accessible in tooth(), ringtooth(), escapementWheel() and pinionEscapementWheel()
Modified escapement to control angle of impulse faces on the pallets, defaults to 45o as per ideal Graham escapement w/o club teeth
Escapement will work if impulse face angles are set to 45o minus tooth lean plus club angle, and drop can be controlled via face angle

v10 -2011 05 08
Modified the drum() module to add holes to attach a string
Backwards compatible with no holes if the new arguments are not passed
Modified pinionDrum() to make use of this new feature, but backwards compatible with no holes if the new arguments are not passed


It includes the following modules:
 
module ring(outerRadius,innerRadius,thickness,outerSegment=30,innerSegment=30)
	creates a hollow cylinder centered at origin
		outerRadius and innerRadius should be self-explanatory
		thickess is along z
		outerSegment is an optional override of the system variable $fn
		innerSegment is an optional override of the system variable $fn

module spokes(number_spokes,spoke_length,spoke_thickness,spoke_width,bore_radius,spoke_rotate=0) 
	creates spokes for a ring
		number_spokes controls the number of spokes
		spoke_length controls the length of the spokes, measured radialy from the center
		spoke_thickness controls the thickness of the spokes, measured along z
		spoke_width controls the width of the spokes, at right angles to length and thickness
		bore_radius controls the radius of the hole at the center
		spoke_rotate allows to rotate the whole set of spokes by some value

module tooth(toothLength,thickness,toothLean,toothSharpness)
	creates a triangular tooth, sharp end at origin
		toothLength is measured along longest side
		thickess is along z
		toothLean measures how far the tooth leans over, in degrees
		toothSharpness measures how sharp the tooth is, in degrees

module ringTooth(outerRadius,innerRadius,thickness,numberTeeth,toothLength)
	creates a ring centered at origin with the child spaced regularly along the outside edge of the inner radius
		outerRadius and innerRadius should be self-explanatory
		thickess is along z 
		numberTeeth controls how many instances of the child are used
		toothlength is used to offset the teeth outward, if needed

module escapementWheel(radius,rimWidth,drumHeight,toothThickness,numberTeeth,toothLength,toothLean,toothSharpness,numberSpokes,spokeWidth,hubWidth,bore)
	creates an escapement wheel centered at origin that matches the escapement if the parameter values are the same
	the teeth can be given a smaller thickness than the wheel, creating a drum, e.g. for powering the escapement via a weight on a string
		radius is the outer radius measured from the tooth tips
		rimWidth is the width of the rim of the wheel, measured radially
		drumHeight is the height of the drum along z
		toothThickess is the thickness of the teeth along z
		numberTeeth controls how many teeth the wheel has
		toothLength is the length of each tooth, 
		toothLean measures how far the tooth leans over clockwise, in degrees
		toothSharpness measures how sharp the tooth is, in degrees
		numberSpokes controls the number of spokes of the wheel
		spokeWidth controls the width of the spokes of the wheel
		hubWidth controls the width of the hub
		bore controls the size of the bore in the hub

module escapement(radius,thickness,faceAngle,armAngle,armWidth,numberTeeth,toothSpan,hubWidth,hubHeight,bore)
	creates a Graham escapement that matches the escapement wheel if the parameter values are the same 
	the escapement is centered at the origin and mirrored around the y axis
	for proper meshing, it must be translated by 2*radius*cos(180/numberTeeth*toothSpan) along the y axis
		radius is the radius of the wheel, not of the escapement
		thickess is along z
		faceAngle controls how many degrees the impulse face covers seen from the hub of the escapement wheel
		armAngle controls the angle of the escapement's arms, 0= no bend
		armWidth controls the width of the arms
		numberTeeth is the number of teeth of the wheel
		toothSpan is how many teeth the escapement spans 
		hubWidth controls the width of the hub
		hubHeight controls the height of the hub along z
		bore controls the size of the bore in the hub

module placeEscapement (angle,radius,numberTeeth,toothSpan)
	places the child (e.g. an instance of the escapement module) in a position to mesh properly with a matching wheel at origin
	also rotates the escapement around the wheel, if needed
		angle is the angle the escapement is rotated around the wheel
		radius is the radius of the escapement wheel (from the tooth tips)
		numberTeeth is the number of teeth in the wheel
		toothSpan is the number of teeth the escapement spans

module hand(hand_length,hand_width,hand_thickness,sleeve_level,pin_radius,sleeve_thickness,loose_fit,tight_fit,negative_space=false) 

module handNotch(notch_height,notch_width,sleeve_level,pin_radius,sleeve_thickness,notch_angle=0,negative_space=false)

module pinionWheel (large_gear_teeth,large_gear_circular_pitch,small_gear_teeth,small_gear_circular_pitch,gear_clearance,gear_backlash,pressure_angle,rim_width,sleeve_level,pin_radius,sleeve_thickness,loose_fit,gear_thickness,sleeve_extension,spacer,spoke_width,notch_angle=0,negative_space=false)

module pinionEscapementWheel (radius,escapement_teeth,tooth_length,tooth_lean,tooth_sharpness,small_gear_teeth,small_gear_circular_pitch,gear_clearance,gear_backlash,pressure_angle,rim_width,sleeve_level,pin_radius,sleeve_thickness,loose_fit,gear_thickness,sleeve_extension,spacer,spoke_width,notch_angle=0,negative_space=false)

module pinionDrum (drum_height,number_spokes,large_gear_teeth,large_gear_circular_pitch,gear_clearance,gear_backlash,pressure_angle,rim_width,sleeve_level,pin_radius,sleeve_thickness,loose_fit,gear_thickness,sleeve_extension,spacer,spoke_width,notch_angle=0,negative_space=false)

*/

module ring(
	outerRadius,
	innerRadius,
	thickness,
	outerSegment=30,
	innerSegment=30)
{
	difference() // hollows out the center of one cylinder with another, smaller one
	{
		cylinder(thickness,outerRadius,outerRadius,$fn=outerSegment);
		translate([0,0,-1])
		cylinder(thickness+2,innerRadius,innerRadius,,$fn=innerSegment);
	}
}

module spokes(
	number_spokes,
	spoke_length,
	spoke_thickness,
	spoke_width,
	bore_radius,
	spoke_rotate=0) 
{
	for ( j=[0:number_spokes-1]) // adds the spokes
	{
		rotate(spoke_rotate+360/number_spokes*j,[0,0,1]) 
		translate([bore_radius,-spoke_width/2,0]) 
		cube([spoke_length-bore_radius,spoke_width,spoke_thickness]);
	}
}

module tooth(
	toothLength,
	thickness,
	toothLean,
	toothSharpness,
	clubSize=0,
	clubAngle=0)
{
	rotate(-toothLean,[0,0,1])
	rotate(180,[0,0,1])
	linear_extrude(height=thickness,center=false,twist=0)
	polygon(
		points=	[ 	
				[0,0],
				[clubSize*toothLength*cos(45+toothLean+clubAngle),-clubSize*toothLength*sin(45+toothLean+clubAngle)],
				[clubSize*toothLength*(0.2+cos(45+toothLean+clubAngle)),-clubSize*toothLength*sin(45+toothLean+clubAngle)],
				[clubSize*toothLength*0.5,-clubSize*toothLength*0.5],
				[toothLength,0],
				[toothLength*cos(toothSharpness),toothLength*sin(toothSharpness)]
				],
		paths=	[
				[0,1,2,3,4,5]
				] );
}

module ringTooth(
	outerRadius,
	innerRadius,
	thickness,
	numberTeeth,
	toothLength)
{
	difference() // makes the center hollow while shaving off any parts of the teeth which might otherwise extend into the center
	 {
		union() // unites the teeth and the ring
		{
			cylinder(thickness,outerRadius,outerRadius,$fn=30);
			for ( i=[0:numberTeeth])
			{
				rotate(i*360/numberTeeth,[0,0,1])
				translate([innerRadius+toothLength,0,0]) 
				child(0);
			}
		}

		translate([0,0,-1])
		cylinder(thickness+2,innerRadius,innerRadius,$fn=30);
	}
}

module drum(
	radius,
	rimWidth,
	drumHeight,
	numberHoles=0,
	holeRadius=0,
	holeRotate=0)
{
	flangeWidth=min(drumHeight/3,rimWidth/2);

	difference()		// makes the center hollow & includes holes to attach string
	 {
		union() 	// builds the drum with flanges
		{
			cylinder(flangeWidth,radius,radius-flangeWidth,$fn=30);
	
			translate([0,0,flangeWidth])
			cylinder(drumHeight-2*flangeWidth,radius-flangeWidth,radius-flangeWidth);
	
			translate([0,0,drumHeight-flangeWidth])
			cylinder(flangeWidth,radius-flangeWidth,radius,$fn=30);
		}

		translate([0,0,-1])
		cylinder(drumHeight+2,radius-rimWidth,radius-rimWidth,$fn=30);

	for ( j=[0:numberHoles-1]) // adds the holes
	{
		translate([0,0,drumHeight/2])
		rotate(holeRotate+360/numberHoles*j,[0,0,1]) 
		rotate(90,[0,1,0])
		cylinder(r=holeRadius,h=radius+1);
	}

	}
}

module escapementWheel(
	radius,
	rimWidth,
	drumHeight,
	toothThickness,
	numberTeeth,
	toothLength,
	toothLean,
	toothSharpness,
	numberSpokes,
	spokeWidth,
	hubWidth,
	bore,
	clubSize=0,
	clubAngle=0)
{
	flangeWidth=min(drumHeight/3,rimWidth/2);

	union() // unites the wheel, the spokes and the hub
		{
		ringTooth(radius-toothLength+rimWidth,radius-toothLength,toothThickness,numberTeeth,toothLength)
		tooth(toothLength,toothThickness,toothLean,toothSharpness,clubSize,clubAngle);

		spokes(numberSpokes,radius-toothLength,drumHeight+toothThickness,spokeWidth,bore,0);

		ring(hubWidth,bore,toothThickness+drumHeight);

		ring(radius-toothLength+rimWidth,radius-toothLength,toothThickness);

		translate([0,0,toothThickness])
		drum(radius-toothLength+rimWidth,rimWidth,drumHeight);
	}
}

module escapement(
	radius,
	thickness,
	faceAngle,
	armAngle,
	armWidth,
	numberTeeth,
	toothSpan,
	hubWidth,
	hubHeight,
	bore,
	negative_space=false,
	space=0.1,
	max_swing=6,
	entryPalletAngle=45,
	exitPalletAngle=45)
{
	faceWidth=2*3.1415*radius*faceAngle/360; // calculate once
	escapementAngle=180/numberTeeth*toothSpan; // calculate once
	
	rotate(90,[0,0,1]) // rotates escapement so pendulum is along y axis
	
	if (negative_space==false)
	{
		union()
		{
			// this is the hub
			ring(hubWidth,bore,hubHeight);
			
			// this is the exit pallet

		// this is the arm of the pallet
			rotate(-90-armAngle,[0,0,1]) 
			translate([bore,-armWidth/2,0]) 
			cube([radius+faceWidth/2-bore,armWidth,thickness]);
			
			// this is the pallet itself
			intersection()
			{
				// this is the ring from which the "dead" faces are made
				// it is important that the arcs be smooth, i.e. $fn high
				// otherwise, there would be some recoil
				ring(radius+faceWidth/2,radius-faceWidth/2,thickness,180,180);
				
				// this is the cube which cuts the pallet where it meets the arm
				rotate(-90-armAngle,[0,0,1])
				translate([radius,0,0])
				rotate(180,[0,0,1]) 
				translate([-0.5*radius,0,-radius])
				cube(2.1*radius);
				
				// this is the cube which cuts the pallet at the impulse face
				translate([-2*radius*cos(escapementAngle),0,0])
				rotate(-escapementAngle,[0,0,1])
				rotate(0,[0,0,1])
				translate([radius,0,0])
				rotate(-90-exitPalletAngle,[0,0,1]) 
				translate([-0.5*radius,0,-radius])
				cube(2.2*radius);
			}

		// this is the entry  pallet

			// this is the arm of the pallet
			rotate(90+armAngle,[0,0,1]) 
			translate([bore,-armWidth/2,0]) 
			cube([radius+faceWidth/2-bore,armWidth,thickness]);
			
			// this is the pallet itself
			intersection()
			{
				// this is the ring from which the "dead" faces are made
				// it is important that the arcs be smooth, i.e. $fn high
				// otherwise, there would be some recoil
				ring(radius+faceWidth/2,radius-faceWidth/2,thickness,180,180);
				
				// this is the cube which cuts the pallet where it meets the arm
				rotate(90+armAngle,[0,0,1])
				translate([radius,0,0])
				rotate(0,[0,0,1]) 
				translate([-0.5*radius,0,-radius])
				cube(2.1*radius);
				
				// this is the cube which cuts the pallet at the impulse face
				translate([-2*radius*cos(escapementAngle),0,0])
				rotate(-escapementAngle,[0,0,1])
				rotate(2*escapementAngle,[0,0,1])
				translate([radius,0,0])
				rotate(-90-entryPalletAngle,[0,0,1]) 
				translate([-0.5*radius,0,-radius])
				cube(2.2*radius);
			}
		}
	}

	if (negative_space==true)
	{
		translate([0,0,-space])
		union()
		{
			ring(hubWidth+space,0,hubHeight+2*space);

			difference()
			{
				ring(radius+faceWidth/2+space,0,thickness+2*space);

				rotate(max_swing-armAngle,[0,0,1])
				translate([-radius,armWidth/2,-1])
				cube(2*radius+faceWidth+2*space);

				mirror([1,0,0])
				rotate(max_swing-armAngle,[0,0,1])
				translate([-radius,armWidth/2,-1])
				cube(2*radius+faceWidth+2*space);
			}
		}
	}
}

module placeEscapement (
	angle,
	radius,
	numberTeeth,
	toothSpan)
{
	rotate(angle,[0,0,1])
	translate([0,2*radius*cos(180/numberTeeth*toothSpan),0])
	child(0);
}

module hand(
	hand_length,
	hand_width,
	hand_thickness,
	sleeve_level,
	pin_radius,
	sleeve_thickness,
	loose_fit,
	tight_fit,
	negative_space=false,
	space=0.1) 
{
	bore_radius=pin_radius+sleeve_level*sleeve_thickness;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;
	
	if (negative_space==false)
	{
		union()
		{
			intersection()
			{
				for ( i=[1:2])
				{
					rotate(i*360/3,[0,0,1])
					translate([bore_radius+loose_fit,-hand_width/2,0])
					cube([sleeve_radius-bore_radius-loose_fit+sleeve_thickness,hand_width,hand_thickness]);
				}
				
				translate(-1,[0,0,1])
				cylinder(hand_thickness+2,sleeve_radius+sleeve_thickness,sleeve_radius+sleeve_thickness);
			}
			
			translate([bore_radius+loose_fit,-hand_width/2,0])
			cube([hand_length-bore_radius-loose_fit,hand_width,hand_thickness]);

			ring(sleeve_radius+sleeve_thickness,bore_radius+tight_fit+sleeve_thickness,hand_thickness);
		}
	}

	if (negative_space==true)
	{
		translate([0,0,-space])
		ring(sqrt(hand_length*hand_length+hand_width*hand_width)+space,0,hand_thickness+2*space);
	}
}

module handNotch(
	notch_height,
	notch_width,
	sleeve_level,
	pin_radius,
	sleeve_thickness,
	notch_angle=0,
	negative_space=false) 
{
	//bore_radius=pin_radius+sleeve_level*sleeve_thickness;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;
	
	if (negative_space==false)
	{
		if (notch_width!=0)
		{
			difference()
			{
				child(0);
				
				for ( i=[0:2])
				{
					rotate(notch_angle+i*360/3,[0,0,1])
					translate([0,-notch_width/2,notch_height])
					cube([sleeve_radius+1,notch_width,notch_height+1]);
				}
			}
		}

		if (notch_width==0)
		{
			child(0);
		}
	}

	if (negative_space==true)
	{
		child(0);
	}
}

module pinionWheel(
	large_gear_teeth,
	large_gear_circular_pitch,
	small_gear_teeth,
	small_gear_circular_pitch,
	gear_clearance=0.2,
	gear_backlash=0.1,
	gear_spacer=0.5,
	pressure_angle=14.5,
	twist_factor=0,
	rim_width,
	sleeve_level=0,
	pin_radius,
	sleeve_thickness,
	loose_fit=0.5,
	gear_thickness,
	sleeve_extension,
	spacer,
	spoke_width,
	notch_angle=0,
	negative_space=false,
	space=0.1) 
{
	large_dedendum_radius=large_gear_circular_pitch*(large_gear_teeth-2)/360-gear_clearance;
	small_dedendum_radius=small_gear_circular_pitch*(small_gear_teeth-2)/360-gear_clearance;
	
	large_addendum_radius=large_gear_circular_pitch*(large_gear_teeth+2)/360-gear_clearance;
	small_addendum_radius=small_gear_circular_pitch*(small_gear_teeth+2)/360-gear_clearance;
	
	bore_radius=pin_radius+sleeve_level*sleeve_thickness+loose_fit;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;

	small_gear_color = [0.88, 0.78, 0.5];
	structure_color = [0.45, 0.43, 0.5];
	large_gear_color = [0.2, 0.2, 0.2];
	
	if (negative_space==false)
	{
		union()
		{
			color(large_gear_color)
			translate([0,0,gear_thickness/2])
			gear (circular_pitch=large_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2-gear_spacer,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2-gear_spacer, 
				hub_diameter=large_dedendum_radius*2,
				bore_diameter=(large_dedendum_radius-rim_width)*2, 
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=large_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=twist_factor*180/large_gear_teeth);

			color(large_gear_color)
			translate([0,0,gear_thickness/2])
			mirror([0,0,1])
			gear (circular_pitch=large_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2, 
				hub_diameter=large_dedendum_radius*2,
				bore_diameter=(large_dedendum_radius-rim_width)*2, 
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=large_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=twist_factor*180/large_gear_teeth);

			color(structure_color)
			translate([0,0,gear_thickness-gear_spacer])
			drum(	small_addendum_radius,rim_width,spacer);

			color(structure_color)
			ring(sleeve_radius,bore_radius,2*gear_thickness+spacer+sleeve_extension);

			color(structure_color)
			spokes(small_gear_teeth,large_dedendum_radius-rim_width,gear_thickness-gear_spacer,spoke_width,bore_radius,0);

			color(structure_color)
			ring(small_addendum_radius-rim_width,bore_radius,gear_thickness+spacer-gear_spacer);
			
			color(small_gear_color)
			translate([0,0,gear_thickness*1.5+spacer])
			gear (circular_pitch=small_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2, 
				hub_diameter=small_dedendum_radius*2,
				bore_diameter=bore_radius*2,  
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=small_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=-twist_factor*180/small_gear_teeth);

			color(small_gear_color)
			translate([0,0,gear_thickness*1.5+spacer])
			mirror([0,0,1])
			gear (circular_pitch=small_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2+gear_spacer,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2+gear_spacer, 
				hub_diameter=small_dedendum_radius*2,
				bore_diameter=bore_radius*2,  
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=small_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=-twist_factor*180/small_gear_teeth);
		}
	}

	if (negative_space==true)
	{
		color(structure_color)
		translate([0,0,-space])
		union()
		{
			ring(large_addendum_radius+space,0,gear_thickness+2*space);

			ring(small_addendum_radius+space,0,2*gear_thickness+spacer+2*space);

			ring(sleeve_radius+space,0,2*gear_thickness+spacer+sleeve_extension+2*space);
		}
	}
}

module pinionEscapementWheel (
	radius,
	escapement_teeth,
	tooth_length,
	tooth_lean,
	tooth_sharpness,
	small_gear_teeth,
	small_gear_circular_pitch,
	gear_clearance=0.2,
	gear_backlash=0.1,
	gear_spacer=0.5,
	pressure_angle=14.5,
	twist_factor=0,
	rim_width,
	sleeve_level=0,
	pin_radius,
	sleeve_thickness,
	loose_fit=0.5,
	gear_thickness,
	sleeve_extension,
	spacer,
	spoke_width,
	notch_angle=0,
	negative_space=false,
	space=0.1,
	clubSize=0,
	clubAngle=0)
{
	//large_dedendum_radius=large_gear_circular_pitch*(large_gear_teeth-2)/360-gear_clearance;
	small_dedendum_radius=small_gear_circular_pitch*(small_gear_teeth-2)/360-gear_clearance;

	//large_adddendum_radius=large_gear_circular_pitch*(large_gear_teeth+2)/360-gear_clearance;
	small_addendum_radius=small_gear_circular_pitch*(small_gear_teeth+2)/360-gear_clearance;

	bore_radius=pin_radius+sleeve_level*sleeve_thickness+loose_fit;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;

	small_gear_color = [0.88, 0.78, 0.5];
	structure_color = [0.45, 0.43, 0.5];
	//large_gear_color = [0.2, 0.2, 0.2];

	if (negative_space==false)
	{
		union()
		{
			color(structure_color)
			escapementWheel(
				radius,
				rim_width,
				0,
				gear_thickness-gear_spacer,
				escapement_teeth,
				tooth_length,
				tooth_lean,
				tooth_sharpness,
				small_gear_teeth,
				spoke_width,
				small_addendum_radius,
				bore_radius,
				clubSize,
				clubAngle);

			color(structure_color)
			translate([0,0,gear_thickness-gear_spacer])
			drum(	small_addendum_radius,rim_width,spacer);

			color(structure_color)
			ring(sleeve_radius,bore_radius,2*gear_thickness+spacer+sleeve_extension);

			color(structure_color)
			ring(small_addendum_radius-rim_width,bore_radius,gear_thickness+spacer-gear_spacer);
			
			color(small_gear_color)
			translate([0,0,gear_thickness*1.5+spacer])
			gear (circular_pitch=small_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2, 
				hub_diameter=small_dedendum_radius*2,
				bore_diameter=bore_radius*2,  
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=small_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=-twist_factor*180/small_gear_teeth);

			color(small_gear_color)
			translate([0,0,gear_thickness*1.5+spacer])
			mirror([0,0,1])
			gear (circular_pitch=small_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2+gear_spacer,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2+gear_spacer, 
				hub_diameter=small_dedendum_radius*2,
				bore_diameter=bore_radius*2,  
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=small_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=-twist_factor*180/small_gear_teeth);
		}
	}

	if (negative_space==true)
	{
		color(structure_color)
		translate([0,0,-space])
		union()
		{
			ring(radius+space,0,gear_thickness+2*space);

			ring(small_addendum_radius+space,0,2*gear_thickness+spacer+2*space);

			ring(sleeve_radius+space,0,2*gear_thickness+spacer+sleeve_extension+2*space);
		}
	}

}

module pinionDrum (
	drum_height,
	large_gear_teeth,
	large_gear_circular_pitch,
	gear_clearance=0.2,
	gear_backlash=0.1,
	gear_spacer=0.5,
	pressure_angle=14.5,
	twist_factor=0,
	rim_width,
	sleeve_level=0,
	pin_radius,
	sleeve_thickness,
	loose_fit=0.5,
	gear_thickness,
	sleeve_extension,
	spacer,
	number_spokes,
	spoke_width,
	number_holes=0,
	hole_radius=0,
	notch_angle=0,
	negative_space=false,
	space=0.1) 
{
	large_dedendum_radius=large_gear_circular_pitch*(large_gear_teeth-2)/360-gear_clearance;
	//small_dedendum_radius=small_gear_circular_pitch*(small_gear_teeth-2)/360-gear_clearance;
	
	large_addendum_radius=large_gear_circular_pitch*(large_gear_teeth+2)/360-gear_clearance;
	//small_addendum_radius=small_gear_circular_pitch*(small_gear_teeth+2)/360-gear_clearance;
	
	bore_radius=pin_radius+sleeve_level*sleeve_thickness+loose_fit;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;

	//small_gear_color = [0.88, 0.78, 0.5];
	structure_color = [0.45, 0.43, 0.5];
	large_gear_color = [0.2, 0.2, 0.2];

	if (negative_space==false)
	{
		union()
		{
			color(large_gear_color)
			translate([0,0,gear_thickness/2])
			gear (circular_pitch=large_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2-gear_spacer,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2-gear_spacer, 
				hub_diameter=large_dedendum_radius*2,
				bore_diameter=(large_dedendum_radius-rim_width)*2, 
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=large_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=twist_factor*180/large_gear_teeth);

			color(large_gear_color)
			translate([0,0,gear_thickness/2])
			mirror([0,0,1])
			gear (circular_pitch=large_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2, 
				hub_diameter=large_dedendum_radius*2,
				bore_diameter=(large_dedendum_radius-rim_width)*2, 
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=large_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=twist_factor*180/large_gear_teeth);

			color(structure_color)
			translate([0,0,gear_thickness-gear_spacer])
			drum(
				radius=large_dedendum_radius,
				rimWidth=rim_width,
				drumHeight=drum_height+gear_spacer,
				numberHoles=number_holes,
				holeRadius=min(hole_radius,(drum_height+gear_spacer)/6),
				holeRotate=notch_angle+180/number_holes);

			color(structure_color)
			spokes(number_spokes,large_dedendum_radius-rim_width,drum_height+gear_thickness,spoke_width,bore_radius,notch_angle);
	
			color(structure_color)
			ring(sleeve_radius,bore_radius,gear_thickness+drum_height+sleeve_extension);
		}
	}

	if (negative_space==true)
	{
		color(structure_color)
		translate([0,0,-space])
		union()
		{
			ring(large_addendum_radius+space,0,gear_thickness+2*space);

			ring(large_dedendum_radius+space,0,thickness+drum_height+2*space);

			ring(sleeve_radius+space,0,drum_height+sleeve_extension+2*space);
		}
	}
}

module ratchetArm(
	height=4, 
	width=4,
	length=23,
	headLength=12,
	angle=45,
	distance=21) 
{ 
	circleRadius=10;

	translate([distance+width,0,0])
	rotate([0,0,angle])
	difference() 
	{
		union()
		{
		cube([headLength,width,height]);

		cube([length,width/2,height]);
		}

		translate([headLength,circleRadius+width/2,height/2])
		cylinder(r=circleRadius, h=height+1, center=true);
	}
}

module ratchetGear(
	drum_height,
	large_gear_teeth,
	large_gear_circular_pitch,
	gear_clearance=0.2,
	gear_backlash=0.1,
	gear_spacer=0.5,
	pressure_angle=14.5,
	twist_factor=0,
	rim_width,
	sleeve_level=0,
	pin_radius,
	sleeve_thickness,
	loose_fit=0.5,
	gear_thickness,
	sleeve_extension,
	spacer,
	number_spokes,
	spoke_width,
	notch_angle=0,
	negative_space=false,
	space=0.1)
{
	large_dedendum_radius=large_gear_circular_pitch*(large_gear_teeth-2)/360-gear_clearance;
	//small_dedendum_radius=small_gear_circular_pitch*(small_gear_teeth-2)/360-gear_clearance;
	
	large_addendum_radius=large_gear_circular_pitch*(large_gear_teeth+2)/360-gear_clearance;
	//small_addendum_radius=small_gear_circular_pitch*(small_gear_teeth+2)/360-gear_clearance;
	
	bore_radius=pin_radius+sleeve_level*sleeve_thickness+loose_fit;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;

	small_gear_color = [0.88, 0.78, 0.5];
	structure_color = [0.45, 0.43, 0.5];
	large_gear_color = [0.2, 0.2, 0.2];

	if (negative_space==false)
	{
		union()
		{
			color(large_gear_color)
			translate([0,0,gear_thickness/2])
			gear (circular_pitch=large_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2-gear_spacer,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2-gear_spacer, 
				hub_diameter=large_dedendum_radius*2,
				bore_diameter=(large_dedendum_radius-rim_width)*2, 
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=large_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=twist_factor*180/large_gear_teeth);

			color(large_gear_color)
			translate([0,0,gear_thickness/2])
			mirror([0,0,1])
			gear (circular_pitch=large_gear_circular_pitch, 
				gear_thickness = 0, 
				rim_thickness = gear_thickness/2,
				rim_width = rim_width,
				hub_thickness = gear_thickness/2, 
				hub_diameter=large_dedendum_radius*2,
				bore_diameter=(large_dedendum_radius-rim_width)*2, 
				circles=0,
				pressure_angle=pressure_angle,
				number_of_teeth=large_gear_teeth,
				clearance=gear_clearance,
				backlash=gear_backlash,
				twist=twist_factor*180/large_gear_teeth);

			color(structure_color)
			spokes(number_spokes,large_dedendum_radius-rim_width,gear_thickness,spoke_width,bore_radius,notch_angle);

			color(structure_color)
			ring(large_dedendum_radius,large_dedendum_radius-rim_width,gear_thickness);

			color(structure_color)
			ring(0.6*large_dedendum_radius,bore_radius,gear_thickness);

			color(small_gear_color)
			rotate(ratchetAdjust,[0,0,1])
			ringTooth(
				outerRadius=0.5*large_dedendum_radius,
				innerRadius=0.4*large_dedendum_radius,
				thickness=2*gear_thickness,
				numberTeeth=2*number_spokes,
				toothLength=0.2*large_dedendum_radius)

			tooth(
				toothLength=0.3*large_dedendum_radius,
				thickness=2*gear_thickness,
				toothLean=-50,
				toothSharpness=-50,
				clubSize=0,
				clubAngle=0);

			color(structure_color)
			ring(sleeve_radius,bore_radius,gear_thickness+drum_height+sleeve_extension);
		}
	}

	if (negative_space==true)
	{
		color(structure_color)
		translate([0,0,-space])
		union()
		{
			ring(large_addendum_radius+space,0,gear_thickness+2*space);

			ring(sleeve_radius+space,0,drum_height+sleeve_extension+2*space);
		}
	}
}

module ratchetDrum(
	drum_height,
	large_gear_teeth,
	large_gear_circular_pitch,
	gear_clearance=0.2,
	gear_spacer=0.5,
	rim_width,
	sleeve_level=0,
	pin_radius,
	sleeve_thickness,
	loose_fit=0.5,
	gear_thickness,
	sleeve_extension,
	spacer,
	number_spokes,
	spoke_width,
	number_holes=0,
	hole_radius=0,
	notch_angle=0,
	negative_space=false,
	space=0.1)
{
	large_dedendum_radius=large_gear_circular_pitch*(large_gear_teeth-2)/360-gear_clearance;
	//small_dedendum_radius=small_gear_circular_pitch*(small_gear_teeth-2)/360-gear_clearance;
	
	large_addendum_radius=large_gear_circular_pitch*(large_gear_teeth+2)/360-gear_clearance;
	//small_addendum_radius=small_gear_circular_pitch*(small_gear_teeth+2)/360-gear_clearance;
	
	bore_radius=pin_radius+sleeve_level*sleeve_thickness+loose_fit;
	sleeve_radius=pin_radius+(sleeve_level+1)*sleeve_thickness;

	small_gear_color = [0.88, 0.78, 0.5];
	structure_color = [0.45, 0.43, 0.5];
	large_gear_color = [0.2, 0.2, 0.2];

	if (negative_space==false)
	{
		union()
		{
			color(small_gear_color)
			difference()
			{
				spokes(number_spokes,large_dedendum_radius-rim_width,drum_height,spoke_width,bore_radius,notch_angle);

				rotate_extrude()
				translate([0.5*large_dedendum_radius,0,0])
				rotate([0,0,45])
				square(size=0.4*large_dedendum_radius, center=true);
			}

			color(small_gear_color)
			drum(
				radius=large_dedendum_radius,
				rimWidth=rim_width,
				drumHeight=drum_height+gear_spacer,
				numberHoles=number_holes,
				holeRadius=min(hole_radius,(drum_height+gear_spacer)/6),
				holeRotate=notch_angle+180/number_holes);

			color(large_gear_color)
			rotate(ratchetAdjust,[0,0,1])
			for (i=[0:number_spokes-1])
			{
				rotate(i*360/number_spokes,[0,0,1])
				ratchetArm(
					height=gear_thickness, 
					width=0.1*large_dedendum_radius,
					 length=0.72*large_dedendum_radius,
					headLength=large_dedendum_radius/3,
					angle=90,
					distance=0.5*large_dedendum_radius);
			}

			color(small_gear_color)
			ring(sleeve_radius,bore_radius,drum_height+sleeve_extension);
		}
	}

	if (negative_space==true)
	{
		color(structure_color)
		translate([0,0,-space])
		union()
		{
			ring(large_addendum_radius+space,0,gear_thickness+2*space);

			ring(sleeve_radius+space,0,drum_height+sleeve_extension+2*space);
		}
	}
}