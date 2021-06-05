package lazylambda.core;

using lazylambda.Core;

class MapIterator<A, B> {
    final iter: Iterator<A>;
    final fun: A -> B;

    public inline function new(iter: Iterator<A>, fun: A -> B) {
        this.iter = iter;
        this.fun = fun;
    }

    public inline function hasNext(): Bool {
        return iter.hasNext();
    }

    public inline function next(): B {
        return fun(iter.next());
    }
}
