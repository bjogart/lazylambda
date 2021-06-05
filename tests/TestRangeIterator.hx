package tests;

import utest.Assert;
import utest.ITest;

using tink.CoreApi;
using fount.Core;
using lazylambda.Core;

class TestRangeIterator implements ITest {
    public function new() {}

    function test_empty_range_with_0_step_succeeds_with_empty_iterator() {
        final iter = 0.rangeTo(0, 0).sure();
        Assert.isFalse(iter.hasNext());
    }

    function test_empty_range_with_misaligned_step_returns_MisalignedStep_Failure() {
        switch 0.rangeTo(0, 1) {
            case Failure(MisalignedStep(_, _, _)): Assert.pass();
            case _: Assert.fail();
        }
        switch 0.rangeTo(0, -1) {
            case Failure(MisalignedStep(_, _, _)): Assert.pass();
            case _: Assert.fail();
        }
    }

    function test_empty_range_without_step_succeeds_with_empty_iterator() {
        final iter = 0.rangeTo(0).sure();
        Assert.isFalse(iter.hasNext());
    }

    function test_range_with_aligned_step() {
        final iter = 0.rangeTo(10, 1).sure();
        for (i in 0...10) {
            Assert.isTrue(iter.hasNext());
            Assert.equals(i, iter.next());
        }
        Assert.isFalse(iter.hasNext());
    }

    function test_range_without_step() {
        final iter = 0.rangeTo(10).sure();
        for (i in 0...10) {
            Assert.isTrue(iter.hasNext());
            Assert.equals(i, iter.next());
        }
        Assert.isFalse(iter.hasNext());
    }

    function test_range_with_bigger_step() {
        final iter = 0.rangeTo(10, 3).sure();
        for (i in 0...4) {
            Assert.isTrue(iter.hasNext());
            Assert.equals(3 * i, iter.next());
        }
        Assert.isFalse(iter.hasNext());
    }

    function test_reversed_range_with_negative_step() {
        final iter = 10.rangeTo(0, -1).sure();
        for (i in 0...10) {
            Assert.isTrue(iter.hasNext());
            Assert.equals(10 - i, iter.next());
        }
        Assert.isFalse(iter.hasNext());
    }

    function test_reversed_range_without_step() {
        final iter = 10.rangeTo(0).sure();
        for (i in 0...10) {
            Assert.isTrue(iter.hasNext());
            Assert.equals(10 - i, iter.next());
        }
        Assert.isFalse(iter.hasNext());
    }

    function test_reversed_range_with_bigger_negative_step() {
        final iter = 10.rangeTo(0, -3).sure();
        for (i in 0...4) {
            Assert.isTrue(iter.hasNext());
            Assert.equals(10 - 3 * i, iter.next());
        }
        Assert.isFalse(iter.hasNext());
    }

    function test_range_with_misaligned_step_returns_MisalignedStep_failure() {
        switch 0.rangeTo(10, 0) {
            case Failure(MisalignedStep(_, _, _)): Assert.pass();
            case _: Assert.fail();
        }

        switch 0.rangeTo(10, -1) {
            case Failure(MisalignedStep(_, _, _)): Assert.pass();
            case _: Assert.fail();
        }

        switch 10.rangeTo(0, 0) {
            case Failure(MisalignedStep(_, _, _)): Assert.pass();
            case _: Assert.fail();
        }

        switch 10.rangeTo(0, 3) {
            case Failure(MisalignedStep(_, _, _)): Assert.pass();
            case _: Assert.fail();
        }
    }
}
