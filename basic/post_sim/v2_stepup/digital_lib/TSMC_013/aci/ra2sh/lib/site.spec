# $Revision: 1.15 $
# generic switches
instname=RA2SH
words=4096
bits=16
frequency=1
ring_width=2
mux=16
drive=6
#uti=off
#pipeline=off
#output_enable=off
write_mask=off
wp_size=8
top_layer=met8
power_type=rings
horiz=met3
vert=met4

# advanced options
cust_comment=
left_bus_delim=[
right_bus_delim=]
pwr_gnd_rename=VDD:VDD,GND:VSS
prefix=
pin_space=0.0
name_case=upper
inside_ring_type=GND
check_instname=on
diodes=on
vclef-fp.inst2ring=blockages
vclef-fp.site_def=off

# view-specific switches
ambit.libname=USERLIB
synopsys.libname=USERLIB
tlf.libname=USERLIB
udl.libname=USERLIB
wattwatcher.libname=USERLIB
