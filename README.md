box-task
========

Tests for BI-3DT homework.

Adding test cases
-----------------

To add a test case, open `tests.scad` and add a new test to the end of the file, before the comments section:

    if (t == X) {
      // your test here
    }

Where X is the number of the test and must be `last_number_used+1`, otherwise the test suite breaks.

To be able to see your code, you can do one of the following:

 * Code your test without the `if` statement and surround it by `if` after you are satisfied.
 * Add `t = X;` somewhere outside of `if` statement (i.e. to the global scope), don't forget to remove it before commiting.

**Never manipulate the 3D view by mouse** (zoom, shift, rotate), only manipulate the view by OpenSCAD code:

    if (t == X) {
      translate(...)
        rotate(...)
          box(...);
    }

If you happen to manipulate the view by accident, you can select **Reset view** from the **View** menu.

For your convenience, the module `cut()` is provided, that let you see the slice of an object. See some tests that use it, to see how it works:

    if (t == 8)
      cut()
        box(to_print=false,reserve=0,$fn=100);

The cut is done by XZ plane, and is translated to the view. Also notice that you can and shall use $fn when necessary - for example to avoid different results depending on the initial position of a corner circle/cylinder.


