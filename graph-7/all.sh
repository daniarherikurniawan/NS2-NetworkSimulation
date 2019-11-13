#!/bin/bash
rm eps/tes.eps
cp raw/data0 dat/tes1.dat
cp raw/data1 dat/tes2.dat
cp raw/data2 dat/tes3.dat
cd plot/
gnuplot exp.plt
cd ../
open eps/tes.eps