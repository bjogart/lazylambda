package lazylambda.core;

using fount.Core;

@:forward(length, iterator)
abstract Slice<C, T>(SliceImpl<C, T>) to Iterable<T> {
    public inline function new(col: C, start: Int, length: Int, accessor: (C, Int) -> T) {
        this = new SliceImpl(col, accessor, start, length);
    }

    @:arrayAccess
    public inline function get(i: Int): Option<T> {
        return this.get(i);
    }
}

private class SliceImpl<C, T> {
    public final length: Int;
    final col: C;
    final start: Int;
    final accessor: (C, Int) -> T;

    public function new(col: C, accessor: (C, Int) -> T, start: Int, length: Int) {
        this.col = col;
        this.start = start;
        this.length = length;
        this.accessor = accessor;
    }

    public function get(i: Int): Option<T> {
        @:nullSafety(Off) return i < 0 || i >= length ? None : Some(accessor(col, start + i));
    }

    public inline function iterator(): Iterator<T> {
        return new SliceIterator(col, accessor, start, start + length);
    }
}

private class SliceIterator<C, T> {
    final col: C;
    final end: Int;
    final accessor: (C, Int) -> T;
    var i: Int;

    public inline function new(col: C, accessor: (C, Int) -> T, i: Int, end: Int) {
        this.col = col;
        this.accessor = accessor;
        this.end = end;
        this.i = i;
    }

    public inline function hasNext(): Bool {
        return i < end;
    }

    public inline function next(): T {
        return accessor(col, i++);
    }
}

class ArraySliceTools {
    public static function lift<T>(arr: Array<T>, pos: Int, ?end: Int): Slice<Array<T>, T> {
        final pos = if (pos < 0) {
            (pos + arr.length).max(0);
        } else if (pos >= arr.length) {
            arr.length;
        } else {
            pos;
        }

        final end = if (end == null) {
            arr.length;
        } else if (end < 0) {
            (end + arr.length).max(0);
        } else if (end >= arr.length) {
            arr.length;
        } else {
            end;
        }

        final length = (end - pos).max(0);

        return new Slice(arr, pos, length, (a, i) -> a[i]);
    }
}

class StringSliceTools {
    public static function lift<T>(str: String, pos: Int, ?end: Int): Slice<String, Int> {
        final pos = if (pos < 0) {
            (pos + str.length).max(0);
        } else if (pos >= str.length) {
            str.length;
        } else {
            pos;
        }

        final end = if (end == null) {
            str.length;
        } else if (end < 0) {
            (end + str.length).max(0);
        } else if (end >= str.length) {
            str.length;
        } else {
            end;
        }

        final length = (end - pos).max(0);

        @:nullSafety(Off) return new Slice(str, pos, length, (a, i) -> a.charCodeAt(i));
    }
}
