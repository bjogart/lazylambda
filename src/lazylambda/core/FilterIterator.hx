package lazylambda.core;

using fount.Core;

class FilterIterator<T> {
    static function findNext<T>(iter: Iterator<T>, pred: T -> Bool): Option<T> {
        while (iter.hasNext()) {
            final next = iter.next();
            if (pred(next)) return Some(next);
        }
        return None;
    }

    final iter: Iterator<T>;
    final pred: T -> Bool;
    var _next: Option<T>;

    public inline function new(iter: Iterator<T>, pred: T -> Bool) {
        this.iter = iter;
        this.pred = pred;
        this._next = findNext(iter, pred);
    }

    public inline function hasNext(): Bool {
        return _next.isSome();
    }

    public inline function next(): T {
        final next = _next;
        _next = findNext(iter, pred);
        return next.unwrap();
    }
}
