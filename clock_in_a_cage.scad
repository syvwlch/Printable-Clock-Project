// Clock geartrain

use <mcad/involute_gears.scad>
include <clockworkLibrary.scad> // version 9

// Objects
v=0;// only for assembly visualization, keep at zero for printable parts
//v=-1.5;
assembly();// visualization with animation; ring plates removed
//sunM();
//ringM();
//ringH();
//sunH();
//ring2H();
//planets();
//escapeWheel();

// Overall Parameters 

explodeZ=5;//5;				// distance in Z between objects in exploded view
explodeR=30;//30;			// distance radially between objects in exploded view

cageArms=4;				// number of arms of the cage
cageLength=40;				// length of the arms of the cage
socketLength=5;				// length of arm sockets
th=1; 					// thickness of arm sockets
overlap=20;				// overlap from outer rings to hold on ring2H
secondLength=0.414*40;		// length of the second hand
minuteLength=0.6*secondLength;	// length of the minute hand
hourLength=0.3*secondLength;	// length og the hour hand
cageWidth=2;				// width of the arms of the cage
handWidth=5;				// width of the hands

// Escapement Wheel Parameters
radius=40;
numberTeeth=15; // number of teeth in the escapement wheel
toothLength=15; // length of the tooth along longest face and to inner radius of the wheel
toothLean=15; // how much the tooth leans over, clockwise, in degrees
toothSharpness=10; // the angle between the two side of each tooth
clubSize=0.2; // relative size of the club on the teeth 
clubAngle=22.5; // impulse face angle
rimWidth=4; // width of the rim
drumHeight=12; // height of the drum on the escapement
numberSpokes=3;
spokeWidth=handWidth;

// Escapement Parameters
toothSpan=3.5; // how many teeth the escapement spans
faceAngle=6; // how many degrees the impulse face covers seen from the hub of the escapement wheel
armAngle=26; // angle of the escapement's arms
armWidth=4; // width of the escapement's arms
hubWidth=5; // width of the escapement's hub
bore=3; // radius of the shaft

// Gear Parameters
d1=80;// diameter of lower ring
t=4;// thickness of all gears
t1=1.2;// thickness of ring faces
b=0.25;// backlash
c=0.2;// clearance
pa=20;// pressure angle
s=0.4;// vertical clearance
td=0.8;// thickness of planet disk
pd=1.1;// planet disk diameter / pitch diameter
dp=0.85;// ring gear diameter / outside ring diameter
w=1.4;// wall thickness of shaft tubes
wc=0.5;// radial clearance between shaft tubes
hh=10+t1+t;// height of hour shaft
dh=5;// difference in height between shafts

// mintues to hours 1:60
nsM=19;// number of teeth on sun (lower)
np1M=20;// number of teeth on lower planet
deltaM=-2;// difference in teeth between upper and lower

// hours to half-day 1:12
nsH=12;// number of teeth on sun (lower)
np1H=16;// number of teeth on lower planet
deltaH=-8;// difference in teeth between upper and lower

//--------- Don't edit below here unless you know what you're doing.

nr1M=nsM+2*np1M;// number of teeth on lower ring
pitchM=nr1M/(d1*dp);// diametral pitch of all gears
nr2M=nr1M+deltaM;
np2M=np1M+deltaM;

R1M=(1+nr1M/nsM);// sun to planet-carrier ratio
R2M=nr2M/((nsM+np1M)*(1-np2M/np1M));// planet-carrier to ring ratio
RpM=(np1M+nsM)/np1M;// planet to planet-carrier ratio
RM=R1M*R2M;// total sun to ring ratio
echo(str(RM, " minutes per hour"));

nr1H=nsH+2*np1H;// number of teeth on lower ring
pitchH=nr1H/(d1*dp);// diametral pitch of all gears
nr2H=nr1H+deltaH;
np2H=np1H+deltaH;

R1H=(1+nr1H/nsH);// sun to planet-carrier ratio
R2H=nr2H/((nsH+np1H)*(1-np2H/np1H));// planet-carrier to ring ratio
RpH=(np1H+nsH)/np1H;// planet to planet-carrier ratio
RH=R1H*R2H;// total sun to ring ratio
echo(str(RH, " hours on face"));

module trapezoidkey(base, top, height, thickness) 
{
	linear_extrude(height=thickness, center=true, convexity=10, twist=0) 
	polygon(
		points=	[
				[-base/2, -height/2], 
				[base/2,-height/2],
				[top/2, height/2],
				[-top/2, height/2] 
				],
		paths=	[[0,1,2,3]], 
		convexity=10);
}

module escapeWheel()
{
	union()
	{
		ring(radius,radius-toothLength,t);

		difference()
		{
			cylinder(drumHeight+2*t,hubWidth,hubWidth);
			translate([0,0,-1])
			cylinder(drumHeight+2*t+2,bore,bore,$fn=6);
		}

		translate([0,0,0])
		escapementWheel(
			radius=radius, 
			rimWidth=rimWidth,
			drumHeight=drumHeight,
			toothThickness=2*t,
			numberTeeth=numberTeeth,
			toothLength=toothLength,
			toothLean=toothLean,
			toothSharpness=toothSharpness,
			numberSpokes=numberSpokes,
			spokeWidth=spokeWidth,
			hubWidth=hubWidth,
			bore=bore,
			clubSize=clubSize,
			clubAngle=clubAngle);

		translate([radius-toothLength,-handWidth/2,0])
		cube([d1/2+secondLength-(radius-toothLength),handWidth,t]);
	}
}

module assembly()
{
	color([0.5,0.5,0.5])
	translate([0,0,-explodeZ])
	ringM();

	for (i=[0:cageArms-1])
	{
		rotate([90,0,90+i*360/cageArms])
		translate([d1/2+explodeR,0,-cageWidth/2])
		arm();
	}

	rotate([0,0,180/nsM+360*RH*RM*$t])
	color([1,0,0])
	{
		sunM();

		rotate(90-180/nsM,[0,0,1])
		translate([0,0,-2*th-2*explodeZ])
		mirror([0,0,1])
		escapeWheel();
	}

	color([0,1,1])
	translate([0,0,-t-2*th-2*explodeZ])
	mirror([0,0,1])
	placeEscapement(180,radius,numberTeeth,toothSpan) 
	escapement( 
		radius=radius, 
		thickness=t,
		faceAngle=faceAngle,
		armAngle=armAngle,
		armWidth=armWidth,
		numberTeeth=numberTeeth,
		toothSpan=toothSpan,
		hubWidth=hubWidth,
		hubHeight=t,
		bore=bore,
		negative_space=false,
		space=0.1,
		max_swing=6,
		entryPalletAngle=45-toothLean+clubAngle, 
		exitPalletAngle=45-toothLean+clubAngle); 

	for (i=[0:2])
	{
		rotate([0,0,120*i+360*RH*R2M*$t])
		translate([(nsM+np1M)/pitchM/2,0,explodeZ])
		rotate([0,0,-120*i-360*RH*R2M*(1+RpM)*$t])
		planetM();
	}

	translate([0,0,2*t+2*s+td+0.1+2*explodeZ])
	rotate([0,0,360*RH*$t])
	color([0,1,0])
	sunH();

	translate([0,0,2*(t+t1+s)+td+4*explodeZ])
	color([0.5,0.5,0.5])
	ringH();

	for (i=[0:3])
	{
		rotate([0,0,90*i+360*R2H*$t])
		translate([(nsH+np1H)/pitchH/2,0,2*(t+t1+s)+td+5*explodeZ])
		rotate([0,0,-90*i-360*R2H*(1+RpH)*$t])
		planetH();
	}

	translate([0,0,4*(t+s)+2*(t1+td)+0.1+6*explodeZ])
	rotate([0,0,360*$t])
	color([0,0,1])
	ring2H();
}

module arm()
{
	union()
	{
		cube([cageLength,t,cageWidth]);
		
		translate([0,2*(t+t1+s)+td,0])
		cube([cageLength,t,cageWidth]);
		
		translate([-overlap,4*(t+s)+2*(t1+td)+0.5+t1,0])
		cube([cageLength+overlap,t,cageWidth]);

		translate([minuteLength,0,0])
		cube([cageLength-minuteLength,4*(t+s)+2*(t1+td)+0.1+t1+t,cageWidth]);
	}
}

module planets()
{
	for (i=[0:1])
		translate([-15+30*i,0,0])planetH();
	for (i=[0:1])
		translate([-15+30*i,-30,0])planetH();
	for (i=[0:2])
		translate([-30+30*i,30,0])planetM();
}

module sunM()
{
	mirror([0,0,1])
	union()
	{
		mirror([0,0,1])
		sun(nsM,pitchM);

		cylinder(3*t,bore,bore,$fn=6);
	}
}

module planetM() planet(np1M,np2M,pitchM);

module ringM()
{
	union()
	{
		difference()
		{
			ring_local(nr1M,pitchM);
			translate([0,0,-t])
			ring(bore,0,3*t);
		}

		for (i=[0:cageArms-1])
		{
			rotate(90+i*360/cageArms,[0,0,1])
			translate([-0.5,0,0])
			translate([d1/2,-cageWidth/2-th,-t1])
			difference()
			{
				cube([socketLength,cageWidth+2*th,t+2*th]);
				
				translate([0,th,th])
				cube([socketLength+1,cageWidth,t]);
			}
		}
	}
}

module sunH()
{
	difference()
	{
		union()
		{
			rotate([180,0,0])
			ring_local(nr2M,pitchM);

			rotate([0,0,180/nsH])
			translate([0,0,2*t1])
			sun(nsH,pitchH);

			rotate(90,[0,0,1])
			translate([d1/2-2,-handWidth/2,v-t])
			cube([minuteLength+2,handWidth,t]);
		}
	}
}

module planetH() planet(np1H,np2H,pitchH);

module ringH()
{
	union()
	{
		difference()
		{
			ring_local(nr1H,pitchH);
			cylinder(r=nsH/pitchH/2/dp,h=5,center=true);
		}

		for (i=[0:cageArms-1])
		{
			rotate(90+i*360/cageArms,[0,0,1])
			translate([-0.5,0,0])
			translate([d1/2,-cageWidth/2-th,-t1])
			difference()
			{
				cube([socketLength,cageWidth+2*th,t+2*th]);
				
				translate([0,th,th])
				cube([socketLength+1,cageWidth,t]);
			}
		}
	}
}

module ring2H()
{
	difference()
	{
		union()
		{
			rotate([180,0,0])ring_local(nr2H,pitchH);

			rotate(90,[0,0,1])
			translate([d1/2-8,-handWidth/2,t1+v-t])
			cube([hourLength+8,handWidth,t]);
		}
	}
}

module sun(ns,pitch)
translate([0,0,-t1])
	gear(number_of_teeth=ns,
		diametral_pitch=pitch,
		gear_thickness=t+t1,
		rim_thickness=t+t1,
		hub_thickness=t+t1,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);

module planet(np1,np2,pitch)
union()
{
	gear(number_of_teeth=np1,
		diametral_pitch=pitch,
		gear_thickness=t+s+td/2,
		rim_thickness=t+s+td/2,
		hub_thickness=t+s+td/2,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);

	translate([0,0,t+s])cylinder(r=pd*np1/pitch/2,h=td,$fn=np1);

	translate([0,0,t+s+td/2])
	gear(number_of_teeth=np2,
		diametral_pitch=pitch,
		gear_thickness=t+s+td/2,
		rim_thickness=t+s+td/2,
		hub_thickness=t+s+td/2,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
}

module ring_local(n,pitch)
rotate([180,0,0])translate([0,0,-t])
difference()
{
	cylinder(r=n/pitch/2/dp,h=t+t1+v);
	translate([0,0,-1])
	gear(number_of_teeth=n,
		diametral_pitch=pitch,
		gear_thickness=t+1,
		rim_thickness=t+1,
		hub_thickness=t+1,
		bore_diameter=0,
		backlash=-b,
		clearance=0,
		pressure_angle=pa);
}