package lazylambda.core;

class IndexedIterator<T> {
    final iter: Iterator<T>;
    var i: Int;

    public inline function new(iter: Iterator<T>) {
        this.iter = iter;
        this.i = 0;
    }

    public inline function hasNext(): Bool {
        return iter.hasNext();
    }

    public inline function next(): { key: Int, value: T } {
        return { key: i++, value: iter.next() }
    }
}
