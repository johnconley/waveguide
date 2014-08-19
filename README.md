Dependencies
------------
- [MPSpack](http://code.google.com/p/mpspack/)

Structure
---------
The optimization directory contains code to optimize a solar cell for maximum absorbance.
The multilayerWrapper function calculates absorbance across the spectrum. See optimumStructure.m
for an example of how to use multilayerWrapper.

The visualization directory contains a GUI designed to explore the resonances of a three-layer
waveguide. The threelayergui function is the entry point to the application.
(old)
change for loop of animmirrorwave and animscattwave to call not full
wave plots and to set axis

change resplotmirror to accept minimum k and kappa

(new)
TEmatrix: constructs TE matrix for three-layer waveguide
TMmatrix: constructs TM matrix for three-layer waveguide
exploreModes: plots resonances of waveguide without scattering
resplot3layer: plots resonances of waveguide with incident wave
scattwave: plots three-layer waveguide w/ incident wave
scattwave2d: same as scattwave but plotted on x-y plane
animscattwave: animates scattwave2d through time
threelayergui: GUI to explore resplot3layer image to see animscattwave for various values
scattintensity:
scattintensity2d:
animscattintensity:
fullscattwave:

mirrorTE: constructs TE matrix for waveguide with PEC
mirrorTM: constructs TM matrix for waveguide with PEC
resplotmirror: plots resonances of mirror waveguide with incident wave
mirrorwave: plots mirror waveguide w/ incident wave
mirrorwave2d: same as mirrorwave but plotted on x-y plane
animmirrorwave: animates mirrorwave2d through time
mirrorgui: GUI to explore resplotmirror to see animmirrorwave for various values

explormap2d:
dielzguide:
GUI_18:


optimization directory contains code to optimize absorption over the solar spectrum

visualization directory contains code to explore the resonances across angle and frequency of
incident light and explore how the waves travel through the waveguide
