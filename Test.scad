use <mcad/involute_gears.scad>
include <clockworkLibrary.scad>

pinionDrum(
drum_height=30,
number_spokes=5,
large_gear_teeth=32, 
large_gear_circular_pitch=360*30/32,
gear_clearance=0.2,
gear_backlash=0.1,
gear_spacer=0.5,
pressure_angle=14.5,
twist_factor=1,
rim_width=3,
sleeve_level=0,
pin_radius=3,
sleeve_thickness=2,
loose_fit=0.5,
gear_thickness=10,
sleeve_extension=10,
spacer=2,
spoke_width=5,
notch_angle=0,
negative_space=false,
space=0.1);