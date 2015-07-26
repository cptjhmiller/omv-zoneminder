#!/bin/sh
value=`cat debian/patches/series`
for items in $value
do
 patch -p0 < debian/patches/$items
done
