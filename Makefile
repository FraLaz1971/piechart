# $Id: makefile,v 1.12 2004/09/28 19:15:08 bernhard Exp $
# Copyright (C) 1997-2000, 2004 Bernhard Reiter <bernhard@intevation.de>
#
# The programm is Free Software published under the GNU GPL v>=2
# and comes without any warranty or fitness for a particular purpose.

# you have to change the following paths to where you have installed plotutils
BASE=/opt/plotutils
#PLOTLIBPATH is where plotutils lib libplot.so is
PLOTLIBPATH=/usr/local/lib
#PLOTLIBPATH2 is where plotutils lib libcommon.a is
PLOTLIBPATH2=/$(BASE)/lib
#PLOTBINPATH is where plotutils executables (graph, spline, plot, ...) has been installed
PLOTBINPATH=/usr/local/bin
PLOTINCLUDEPATH=$(BASE)/include
PLOTINCLUDEPATH2=$(BASE)
PLOT2X=$(PLOTBINPATH)/plot -T X
#postscript viewer (i use okular but you can use gv or whatever) able to read from stdin
PSVIEWER=okular 
#image viewer (i use okular but you can use gwenview, eog or whatever) able to read from file
IMGVIEWER=okular
CC=gcc -Wall -ansi
CFLAGS= -I$(PLOTINCLUDEPATH) -I$(PLOTINCLUDEPATH2)
#uncomment under if you want to use the DEBUG preprocessor definition switch 
#CFLAGS= -g -I$(PLOTINCLUDEPATH) -DDEBUG
LDFLAGS= -L$(PLOTLIBPATH) -L$(PLOTLIBPATH2)


all: piechart test


test:: piechart probe.dat
	<probe.dat ./piechart -r0.6 -d0.05 -C skyblue2,green,aquamarine -t "Hello World" -fr -p "Joe Box" -T X -B 300x500+50+0 -n 0.1

moretests:: piechart probe.dat
	<probe.dat ./piechart -r0.6 -d0.05 -C skyblue2,green,aquamarine -t "Hello World" -p "Cliff" -n 0.15 | $(PLOT2X)
	<probe.dat ./piechart -r0.6 -d0.05 -C skyblue2,green,aquamarine -t "Hello World" | $(PLOT2X)


	
probe.dat:
	echo '#just a very small input file for testing piechart'>probe.dat
	echo 'Bernhard 50'  >>probe.dat
	echo 'Cliff	20' >>probe.dat
	echo 'Joe Box 10'   >>probe.dat
	
piechart: piechart.c $(PLOTLIBPATH)/libplot.so
	$(CC) $(CFLAGS) $(LDFLAGS) \
		piechart.c -o $@ -lplot -lm -lcommon

