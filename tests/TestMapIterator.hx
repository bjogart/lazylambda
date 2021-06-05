package tests;

import utest.Assert;
import utest.ITest;

using lazylambda.Core;

class TestMapIterator implements ITest {
    public function new() {}

    function test_map_maps_values() {
        final iter = [0, 1, 2, 3].iterator().map(i -> 2 * i);

        Assert.isTrue(iter.hasNext());
        Assert.equals(0, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(2, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(4, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(6, iter.next());
        Assert.isFalse(iter.hasNext());
    }

    function test_flatmap_concats_mapped_iterators() {
        final iter = [[0, 1], [], [2, 3]].iterator().flatMap(arr -> arr.iterator().map(i -> 2 * i));
        Assert.isTrue(iter.hasNext());
        Assert.equals(0, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(2, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(4, iter.next());
        Assert.isTrue(iter.hasNext());
        Assert.equals(6, iter.next());
        Assert.isFalse(iter.hasNext());
    }
}
