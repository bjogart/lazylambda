package lazylambda.core;

using tink.CoreApi;
using fount.Core;

class RangeIterator {
    final dir: Int;
    final end: Int;
    final step: Int;
    var pos: Int;

    public inline function new(start: Int, end: Int, dir: Int, step: Int) {
        this.pos = start;
        this.end = end;
        this.dir = dir;
        this.step = step;
    }

    public inline function hasNext(): Bool {
        return (end - pos).sign() == dir;
    }

    public inline function next(): Int {
        final val = pos;
        pos += step;
        return val;
    }
}

enum RangeIterError {
    MisalignedStep(start: Int, end: Int, step: Int);
}
