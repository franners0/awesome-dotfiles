#!/usr/bin/env bash
#	default color: 178984
oldglyph=#430b10
newglyph=#5c2517

#	Front
#	default color: 36d7b7
oldfront=#891520
newfront=#ab442a

#	Back
#	default color: 1ba39c
oldback=#5e0f16
newback=#752f1d

sed -i "s/#524954/$oldglyph/g" $1
sed -i "s/#9b8aa0/$oldfront/g" $1
sed -i "s/#716475/$oldback/g" $1
sed -i "s/$oldglyph;/$newglyph;/g" $1
sed -i "s/$oldfront;/$newfront;/g" $1
sed -i "s/$oldback;/$newback;/g" $1
