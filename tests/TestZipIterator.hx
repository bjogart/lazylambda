package tests;

import utest.Assert;
import utest.ITest;

using fount.Core;
using lazylambda.Core;

class TestZipIterator implements ITest {
    public function new() {}

    function test_zip_is_empty_if_left_iterator_is_empty() {
        final lhs = new EmptyIterator();
        final rhs = 0...5;
        Assert.isFalse(lhs.zip(rhs).hasNext());
    }

    function test_zip_is_empty_if_right_iterator_is_empty() {
        final lhs = 0...5;
        final rhs = new EmptyIterator();
        Assert.isFalse(lhs.zip(rhs).hasNext());
    }

    function test_zip_concats_items_in_order() {
        final lhs = (0...20).filter(IntTools.isEven);
        final rhs = (0...10).map(i -> i * 2);
        final iter = lhs.zip(rhs);

        var idx = 0;
        for (l => r in iter) {
            Assert.equals(l, r);
            idx++;
        }
        Assert.equals(idx, 10);
    }
}
