package lazylambda.core;

using lazylambda.Core;

class ConcatIterator<T> {
    final iters: Iterator<Iterator<T>>;
    var curr: Iterator<T>;

    public inline function new(iters: Iterator<Iterator<T>>) {
        this.iters = iters.filter(iter -> iter.hasNext());
        curr = iters.hasNext() ? this.iters.next() : new EmptyIterator();
    }

    public inline function hasNext(): Bool {
        return iters.hasNext() || curr.hasNext();
    }

    public inline function next(): T {
        if (!curr.hasNext()) curr = iters.next();
        return curr.next();
    }
}
