#!/bin/bash
MAXTEST=5

mkdir students 2>/dev/null
mkdir good 2>/dev/null

rm good/*.png 2>/dev/null

tests() {
  REPORT=index.html
  echo '<html><body>' > $REPORT
  for i in $(seq 1 $MAXTEST); do
    openscad -D t=$i -o t$i.png tests.scad --render --camera=0,0,0,55,0,25,140 --imgsize=400,400
    echo "<h1>$i</h1>" >> $REPORT
    echo "<img src=\"../../good/t$i.png\" title=\"good\"/>" >> $REPORT
    echo "<img src=\"t$i.png\" title=\"student\"/>" >> $REPORT
    echo "<hr />" >> $REPORT
  done
  echo '</body></html>' >> $REPORT
}

tests
mv *.png good/
rm index.html

for DIR in students/*; do
  pushd $DIR > /dev/null
  cp ../../tests.scad .
  tests
  rm tests.scad
  popd > /dev/null
done
