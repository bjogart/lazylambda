package tests;

import tests.ds.Obj;
import utest.Assert;
import utest.ITest;

using fount.Core;
using datum.Core;
using lazylambda.Core;

class TestTerminals implements ITest {
    public function new() {}

    function test_toStr_adds_no_separators_for_empty_iterator() {
        final it = [].iterator();

        Assert.equals("[]", it.toStr());
    }

    function test_toStr_adds_no_separators_for_singleton_iterator() {
        final it = [new Obj(1)].iterator();

        Assert.equals("[1]", it.toStr());
    }

    function test_toStr_adds_one_separator_between_items() {
        final it = [new Obj(1), new Obj(2), new Obj(3)].iterator();

        Assert.equals("[1, 2, 3]", it.toStr());
    }

    function test_toStr_adds_default_separators_if_not_specified() {
        final it = [new Obj(1), new Obj(2), new Obj(3)].iterator();

        Assert.equals("[1, 2, 3]", it.toStr());
    }

    function test_toRepr() {
        final it = [new Obj(1), new Obj(2), new Obj(3)].iterator();

        Assert.equals("[Obj(1i), Obj(2i), Obj(3i)]", it.toRepr());
    }

    function test_all_is_false_if_any_item_is_false() {
        final iter = [0, 1, 4, 6, 8].iterator();
        Assert.isFalse(iter.all(IntTools.isEven));
    }

    function test_all_is_true_if_all_items_are_false() {
        final iter = [0, 2, 4, 6, 8].iterator();
        Assert.isTrue(iter.all(IntTools.isEven));
    }

    function test_any_is_false_if_all_items_are_false() {
        final iter = [0, 2, 4, 6, 8].iterator();
        Assert.isFalse(iter.any(IntTools.isOdd));
    }

    function test_any_is_true_if_any_item_is_true() {
        final iter = [0, 1, 4, 6, 8].iterator();
        Assert.isTrue(iter.any(IntTools.isOdd));
    }

    function test_cmp_counts_empty_iterators_as_equal() {
        Assert.equals(0, new EmptyIterator().cmp(new EmptyIterator()));
    }

    function test_cmp_counts_equal_iterators_as_equal() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];

        Assert.equals(0, arrA.iterator().cmp(arrB.iterator()));
        Assert.equals(0, arrB.iterator().cmp(arrA.iterator()));
    }

    function test_cmp_counts_shorter_iterator_as_smaller() {
        final shortArr = [new Obj(0), new Obj(1), new Obj(2), new Obj(3)];
        final longArr = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];

        Assert.equals(-1, shortArr.iterator().cmp(longArr.iterator()));
        Assert.equals(1, longArr.iterator().cmp(shortArr.iterator()));
    }

    function test_cmp_counts_iterators_with_different_values_according_to_first_different_value() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2)];
        final arrB = [new Obj(1), new Obj(1), new Obj(2)];
        final arrC = [new Obj(1), new Obj(1), new Obj(2)];

        Assert.equals(-1, arrA.iterator().cmp(arrB.iterator()));
        Assert.equals(1, arrB.iterator().cmp(arrA.iterator()));
        Assert.equals(-1, arrA.iterator().cmp(arrC.iterator()));
        Assert.equals(1, arrC.iterator().cmp(arrA.iterator()));
    }

    function test_eq_is_false_if_iterators_are_of_different_length() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4)];

        Assert.isFalse(arrA.iterator().eq(arrB.iterator()));
        Assert.isFalse(arrB.iterator().eq(arrA.iterator()));
    }

    function test_eq_is_false_if_iterators_have_different_values() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(6), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];

        Assert.isFalse(arrA.iterator().eq(arrB.iterator()));
        Assert.isFalse(arrB.iterator().eq(arrA.iterator()));
    }

    function test_eq_is_true_if_iterators_have_same_values_and_same_length() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];

        Assert.isTrue(arrA.iterator().eq(arrB.iterator()));
        Assert.isTrue(arrB.iterator().eq(arrA.iterator()));
    }

    function test_ne_is_true_if_iterators_are_of_different_length() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4)];

        Assert.isTrue(arrA.iterator().ne(arrB.iterator()));
        Assert.isTrue(arrB.iterator().ne(arrA.iterator()));
    }

    function test_ne_is_true_if_iterators_have_different_values() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(1), new Obj(3), new Obj(3), new Obj(4), new Obj(5)];

        Assert.isTrue(arrA.iterator().ne(arrB.iterator()));
        Assert.isTrue(arrB.iterator().ne(arrA.iterator()));
    }

    function test_ne_is_false_if_iterators_have_same_values_and_same_length() {
        final arrA = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];
        final arrB = [new Obj(0), new Obj(1), new Obj(2), new Obj(3), new Obj(4), new Obj(5)];

        Assert.isFalse(arrA.iterator().ne(arrB.iterator()));
        Assert.isFalse(arrB.iterator().ne(arrA.iterator()));
    }

    function test_find_returns_None_if_no_item_is_found() {
        Assert.isTrue((0...10).map(i -> i * 2).find(IntTools.isOdd).isNone());
    }

    function test_find_returns_first_item_for_which_pred_is_true() {
        Assert.equals(3, [0, 2, 3, 6, 8, 10].iterator().find(IntTools.isOdd).unwrap());
    }

    function test_findIndex_returns_None_if_no_item_is_found() {
        Assert.isTrue((0...10).map(i -> i * 2).findIndex((_, v) -> v.isOdd()).isNone());
    }

    function test_findIndex_returns_first_item_index_for_which_pred_is_true() {
        Assert.equals(2, [0, 2, 3, 6, 8, 10].iterator().findIndex((_, v) -> v.isOdd()).unwrap());
    }

    function test_fold() {
        Assert.equals(55, (0...11).fold((a, b) -> a + b, 0));
    }

    function test_groupByIndex() {
        final byParity = 0.rangeTo(5, 2).sure().map(Obj.new).groupByIndex(i -> i.val);
        final expected = [
            Some(new List().also(l -> l.add(new Obj(0)))),
            None,
            Some(new List().also(l -> l.add(new Obj(2)))),
            None,
            Some(new List().also(l -> l.add(new Obj(4))))
        ];

        for (val => expectedVal in byParity.iterator().zip(expected.iterator())) {
            Assert.isTrue(val.eqBy(expectedVal, (lhs, rhs) -> lhs.iterator().eq(rhs.iterator())));
        }
    }

    function test_group() {
        final byParity = 0.rangeTo(5, 2).sure().map(Obj.new).group(obj -> obj, TreeDict.create);
        final expected = [
            new List().also(l -> l.add(new Obj(0))),
            new List().also(l -> l.add(new Obj(2))),
            new List().also(l -> l.add(new Obj(4)))
        ];

        for (val => expectedVal in byParity.keyValueIterator().values().zip(expected.iterator())) {
            Assert.isTrue(val.iterator().eq(expectedVal.iterator()));
        }
    }

    function test_reduce_when_iterator_is_empty() {
        Assert.isTrue(new EmptyIterator().reduce((a, b) -> a + b).isNone());
    }

    function test_reduce_for_nonempty_iterator() {
        Assert.equals(55, (0...11).reduce((a, b) -> a + b).unwrap());
    }
}
