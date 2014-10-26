#!/bin/bash
MAXTEST=`grep "^if (t == " tests.scad | wc -l`

mkdir students 2>/dev/null
mkdir good 2>/dev/null

rm good/*.png 2>/dev/null

tests() {
  REPORT=index.html
  echo '<html>' > $REPORT
  echo "<HEAD>" >> $REPORT
  echo "  <meta charset=\"UTF-8\">" >> $REPORT
  echo "  <TITLE>" >> $REPORT
  echo "  BI-3DT Domaci úkol" >> $REPORT
  echo "  </TITLE>" >> $REPORT
  echo "</HEAD>" >> $REPORT
  echo '<body>' >> $REPORT
  rm t*.png 2>/dev/null
  for i in $(seq 1 $MAXTEST); do
    openscad -D t=$i -o t$i.png tests.scad --render --camera=0,0,0,55,0,25,140 --imgsize=400,400 2>log
    echo -n .
    echo "<h1>$i</h1>" >> $REPORT
    echo "<img src=\"../../good/t$i.png\" title=\"good\"/>" >> $REPORT
    echo "<img src=\"t$i.png\" title=\"student\"/>" >> $REPORT
    echo "<pre>" >> $REPORT
    start=`grep "^if (t == $i)" tests.scad -n | cut -d: -f1`
    end=`grep "^if (t == $(($i+1)))" tests.scad -n | cut -d: -f1`
    if [ x$end == x ]; then
      end=`grep "^// Always use" tests.scad -n | cut -d: -f1`
    fi
    tail -n+$(($start)) tests.scad | head -$(($end-$start)) >> $REPORT
    grep ERROR log >> $REPORT
    grep WARNING log >> $REPORT
    echo "</pre><hr />" >> $REPORT
  done
  echo
  echo '</body></html>' >> $REPORT
  rm log
}

echo -n good
tests
mv *.png good/
rm index.html

for DIR in students/*; do
  echo -n ${DIR#*/}
  pushd $DIR > /dev/null
  cp ../../tests.scad .
  tests
  rm tests.scad
  popd > /dev/null
done
