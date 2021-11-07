package lazylambda.core;

import haxe.Exception;

class SingletonIterator<T> {
    final val: T;
    var isNext: Bool;

    public inline function new(val: T) {
        this.val = val;
        this.isNext = true;
    }

    public #if !hl inline #end function hasNext(): Bool {
        return isNext;
    }

    public #if !hl inline #end function next(): T {
        if (isNext) {
            isNext = false;
            return val;
        }
        throw new Exception("next() called twice on SingletonIterator");
    }
}

class SingletonIteratorTools {
    public static inline function iter<T>(val: T): Iterator<T> {
        return new SingletonIterator(val);
    }
}
