package tests;

import utest.Assert;
import utest.ITest;

using lazylambda.Core;

class TestIndexedIterator implements ITest {
    public function new() {}

    function test_indexed() {
        final indices = (0...10).toArray();
        for (i => idx in indices) Assert.equals(idx, i);
    }
}
