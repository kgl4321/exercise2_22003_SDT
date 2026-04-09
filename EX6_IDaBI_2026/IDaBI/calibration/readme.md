# AFC calibration files for databars in building 352

The calibration file focusrite_calibration.m is a calibration file 
for using the Focusrite Scarlett 2i2 soundcards for students and
is used together with the AFC framework by Stephan Ewert. 

The calibration file has to be added in the experiment 
file `*_cfg.m` with the following struct: `def.calScript = 'focusrite'`;

The headphone level on the soundcard should be set to exactly 50%
(12 o-clock position).