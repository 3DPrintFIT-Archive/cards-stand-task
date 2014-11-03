#!/bin/bash

if [ -f cookie.txt ]; then
  COOKIE=`cat cookie.txt`
else
  echo "Provide cookie.txt file with Edux cookie, see cookie.txt.sample" >&2
  exit 1
fi

if [ -f usernames.txt ]; then
  USERNAMES=`cat usernames.txt`
else
  echo "Provide usernames.txt file with all students, see usernames.txt.sample" >&2
  exit 1
fi

for USER in $USERNAMES; do
  dir=students/$USER
  mkdir -p $dir
  pushd $dir > /dev/null
  curl -O https://edux.fit.cvut.cz/courses/BI-3DT/_media/student/$USER/box.zip?purge --cookie "$COOKIE"
  mv -f 'box.zip?purge' box.zip
  if ! unzip -o box.zip; then
    popd > /dev/null
    rm -rf $dir
    continue
  fi
  rm box.zip
  popd > /dev/null
done
