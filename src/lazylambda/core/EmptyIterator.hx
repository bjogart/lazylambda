package lazylambda.core;

import haxe.Exception;

class EmptyIterator<T> {
    public inline function new() {}

    public #if !hl inline #end function hasNext(): Bool {
        return false;
    }

    public #if !hl inline #end function next(): T {
        throw new Exception("next() called on EmptyIterator");
    }
}
