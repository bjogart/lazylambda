package tests;

import utest.Assert;
import utest.ITest;

using lazylambda.Core;

class TestEmptyIterator implements ITest {
    public function new() {}

    function test_empty_iterator_has_no_next() {
        Assert.isFalse(new EmptyIterator().hasNext());
    }

    function test_empty_iterator_throws_on_next_call() {
        Assert.raises(new EmptyIterator().next);
    }
}
