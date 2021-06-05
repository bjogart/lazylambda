package tests;

import utest.Assert;
import utest.ITest;

using fount.Core;
using lazylambda.Core;

class TestFilterIterator implements ITest {
    public function new() {}

    function test_empty_iterator_is_still_empty_when_filtered() {
        Assert.isFalse([].iterator().filter(_ -> false).hasNext());
        Assert.isFalse([].iterator().filter(_ -> true).hasNext());
    }

    function test_items_for_which_pred_is_true_are_filtered() {
        final iter = (0...10).filter(i -> i.isEven());
        Assert.isTrue(iter.hasNext());
        Assert.equals(0, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(2, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(4, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(6, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(8, iter.next());
        Assert.isFalse(iter.hasNext());
    }

    function test_no_items_are_kept_if_pred_is_false() {
        final iter = (0...5).filter(_ -> false);
        Assert.isFalse(iter.hasNext());
    }

    function test_all_items_are_kept_if_pred_is_true() {
        final iter = (0...5).filter(_ -> true);
        Assert.isTrue(iter.hasNext());
        Assert.equals(0, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(1, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(2, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(3, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(4, iter.next());
        Assert.isFalse(iter.hasNext());
    }
}
