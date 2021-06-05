package tests;

import utest.Assert;
import utest.ITest;

using fount.Core;
using lazylambda.Core;

class TestSlice implements ITest {
    static final arr = [0, 1, 2, 3, 4, 5];

    public function new() {}

    function test_array_lift_0_to_length_slice_contains_whole_array() {
        final s = arr.lift(0, arr.length);

        Assert.equals(arr.length, s.length);
        for (i in 0...s.length) Assert.equals(arr[i], s[i].unwrap());
    }

    function test_array_lift_omitting_end_defaults_to_end_of_array() {
        final s = arr.lift(2);

        Assert.equals(arr.length - 2, s.length);
        for (i in 0...s.length) Assert.equals(arr[i + 2], s[i].unwrap());
    }

    function test_array_lift_slice_lifts_upto_but_not_including_end() {
        final s = arr.lift(0, 2);

        Assert.equals(2, s.length);
        for (i in 0...s.length) Assert.equals(arr[i], s[i].unwrap());
    }

    function test_array_lift_endpos_larger_than_array_defaults_to_end_of_array() {
        final s = arr.lift(2, 2 * arr.length);

        Assert.equals(arr.length - 2, s.length);
        for (i in 0...s.length) Assert.equals(arr[i + 2], s[i].unwrap());
    }

    function test_array_lift_negative_pos_indexes_from_end_of_array() {
        final s = arr.lift(-2);

        Assert.equals(2, s.length);
        for (i in 0...s.length) Assert.equals(arr[arr.length - 2 + i], s[i].unwrap());
    }

    function test_array_lift_negative_pos_smaller_than_array_length_defaults_to_0() {
        final s = arr.lift(-2 * arr.length);

        Assert.equals(arr.length, s.length);
        for (i in 0...s.length) Assert.equals(arr[i], s[i].unwrap());
    }

    function test_array_lift_negative_end_indexes_from_end_of_array() {
        final s = arr.lift(0, -2);

        Assert.equals(arr.length - 2, s.length);
        for (i in 0...s.length) Assert.equals(arr[i], s[i].unwrap());
    }

    function test_array_lift_negative_end_smaller_than_array_length_defaults_to_0() {
        final s = arr.lift(0, -2 * arr.length);

        Assert.equals(0, s.length);
    }

    function test_array_lift_slice_is_empty_if_pos_exceeds_array_length() {
        final s = arr.lift(arr.length + 1);

        Assert.equals(0, s.length);
    }

    function test_array_lift_slice_is_empty_if_end_is_smaller_than_pos() {
        final s = arr.lift(3, 1);

        Assert.equals(0, s.length);
    }
}
