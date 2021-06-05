package lazylambda.core;

class ZipIterator<A, B> {
    final a: Iterator<A>;
    final b: Iterator<B>;

    public inline function new(a: Iterator<A>, b: Iterator<B>) {
        this.a = a;
        this.b = b;
    }

    public inline function hasNext(): Bool {
        return a.hasNext() && b.hasNext();
    }

    public inline function next(): { key: A, value: B } {
        return { key: a.next(), value: b.next() }
    }
}
