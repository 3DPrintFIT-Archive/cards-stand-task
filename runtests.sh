#!/bin/bash
MAXTEST=2

mkdir students 2>/dev/null
mkdir good 2>/dev/null

rm good/*.png 2>/dev/null

tests() {
  for i in $(seq 1 $MAXTEST); do
    openscad -D t=$i -o t$i.png tests.scad --render --camera=0,0,0,55,0,25,140 --imgsize=400,400
  done
}

tests
mv *.png good/

for DIR in students/*; do
  pushd $DIR > /dev/null
  cp ../../tests.scad .
  tests
  rm tests.scad
  popd > /dev/null
done
