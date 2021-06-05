package tests;

import utest.ITest;
import utest.Assert;

using lazylambda.Core;

class TestConcatIterator implements ITest {
    public function new() {}

    function test_concat_maps_empty_iterators_to_empty_iterator() {
        final it1 = [].iterator();
        final it2 = [].iterator();

        Assert.isFalse(it1.concat(it2).hasNext());
    }

    function test_concat_maps_empty_first_iterator_to_second_iterator() {
        final it1 = [].iterator();
        final it2 = [3, 4].iterator();
        final it = it1.concat(it2);

        Assert.isTrue(it.hasNext());
        Assert.equals(3, it.next());
        Assert.isTrue(it.hasNext());
        Assert.equals(4, it.next());
        Assert.isFalse(it.hasNext());
    }

    function test_concat_maps_empty_second_iterator_to_first_iterator() {
        final it1 = [1, 2].iterator();
        final it2 = [].iterator();
        final it = it1.concat(it2);

        Assert.isTrue(it.hasNext());
        Assert.equals(1, it.next());
        Assert.isTrue(it.hasNext());
        Assert.equals(2, it.next());
        Assert.isFalse(it.hasNext());
    }

    function test_concat_concatenates_iterator_values() {
        final it1 = [1, 2].iterator();
        final it2 = [3, 4].iterator();
        final it = it1.concat(it2);

        Assert.isTrue(it.hasNext());
        Assert.equals(1, it.next());
        Assert.isTrue(it.hasNext());
        Assert.equals(2, it.next());
        Assert.isTrue(it.hasNext());
        Assert.equals(3, it.next());
        Assert.isTrue(it.hasNext());
        Assert.equals(4, it.next());
        Assert.isFalse(it.hasNext());
    }
}
