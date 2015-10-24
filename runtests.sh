#!/bin/bash
MAXTEST=`grep "^if (t == " tests.scad | wc -l`

mkdir students 2>/dev/null
mkdir good 2>/dev/null

rm good/*.png 2>/dev/null

tests() {
  echo -en '\e[1;32m'"$1"'\e[m'
  REPORT=index.html
  echo '<html>' > $REPORT
  echo "<head>" >> $REPORT
  echo "  <meta charset=\"UTF-8\">" >> $REPORT
  echo "  <title>$1 - BI-3DT Domácí úkol</title>" >> $REPORT
  echo "  <script src=\"../../js/jquery-1.11.0.min.js\"></script>" >> $REPORT
  echo "  <script src=\"../../js/score.js\"></script>" >> $REPORT
  echo "</head>" >> $REPORT
  echo '<body>' >> $REPORT
  rm t*.png 2>/dev/null
  for i in $(seq 1 $MAXTEST); do
    (
      openscad -D t=$i -o t$i.png tests.scad --render --camera=0,0,0,55,0,25,140 --imgsize=400,400 2>/dev/null
      echo -n .
    ) &
    echo "<h1>$i</h1>" >> $REPORT
    echo "<img src=\"../../good/t$i.png\" title=\"good\"/>" >> $REPORT
    echo "<img src=\"t$i.png\" title=\"student\"/>" >> $REPORT
    echo "<input id=\"error$i\" class=\"error\" type=\"checkbox\" name=\"error$i\" value=\"error$i\">Obsahuje chybu<br>" >> $REPORT
    echo "<pre>" >> $REPORT
    start=`grep "^if (t == $i)" tests.scad -n | cut -d: -f1`
    end=`grep "^if (t == $(($i+1)))" tests.scad -n | cut -d: -f1`
    if [ x$end == x ]; then
      end=`grep "^// Always use" tests.scad -n | cut -d: -f1`
    fi
    tail -n+$(($start)) tests.scad | head -$(($end-$start)) >> $REPORT
    echo "</pre><hr />" >> $REPORT
  done

  echo "<p id=\"info\">&nbsp;</p>" >> $REPORT
  echo "<p id=\"result\">&nbsp;</p>" >> $REPORT
  echo '<button id="calculate" name="calculate" class="btn btn-primary">Spočítat body</button>' >> $REPORT
  echo "<a href=\"https://edux.fit.cvut.cz/courses/BI-3DT/classification/student/$1/start\">Edux $1</a>" >> $REPORT
  echo '</body></html>' >> $REPORT
}

tests goodgood
for job in `jobs -p`; do wait $job; done
echo

mv t*.png good/
rm index.html

for DIR in students/*; do
  pushd $DIR > /dev/null
  cp ../../tests.scad .
  tests ${DIR#*/}
  for job in `jobs -p`; do wait $job; done
  echo
  rm tests.scad
  popd > /dev/null
done
