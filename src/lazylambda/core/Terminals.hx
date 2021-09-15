package lazylambda.core;

using fount.Core;
using datum.Core;
using lazylambda.Core;

class Terminals {
    public static function all<T>(iter: Iterator<T>, pred: T -> Bool): Bool {
        for (it in iter) {
            if (!pred(it)) return false;
        }
        return true;
    }

    public static function any<T>(iter: Iterator<T>, pred: T -> Bool): Bool {
        for (it in iter) {
            if (pred(it)) return true;
        }
        return false;
    }

    public static inline function cmp<T: Ord<T>>(a: Iterator<T>, b: Iterator<T>): Int {
        return a.cmpBy(b, (t1, t2) -> t1.cmp(t2));
    }

    public static function cmpBy<T>(a: Iterator<T>, b: Iterator<T>, comparator: (T, T) -> Int): Int {
        while (a.hasNext() && b.hasNext()) {
            final cmp = comparator(a.next(), b.next());
            if (cmp != 0) return cmp;
        }
        return if (b.hasNext()) {
            -1;
        } else if (a.hasNext()) {
            1;
        } else {
            0;
        }
    }

    public static inline function eq<T: Eq<T>>(a: Iterator<T>, b: Iterator<T>): Bool {
        return a.eqBy(b, (v1, v2) -> v1.eq(v2));
    }

    public static function eqBy<T>(a: Iterator<T>, b: Iterator<T>, eq: (T, T) -> Bool): Bool {
        while (a.hasNext() && b.hasNext()) {
            if (!eq(a.next(), b.next())) return false;
        }
        return a.hasNext() == b.hasNext();
    }

    public static function find<T>(iter: Iterator<T>, pred: T -> Bool): Option<T> {
        for (it in iter) {
            if (pred(it)) return Some(it);
        }
        return None;
    }

    public static inline function findIndex<T>(iter: Iterator<T>, pred: (Int, T) -> Bool): Option<Int> {
        return iter.indexed().find(iit -> pred(iit.key, iit.value)).map(iit -> iit.key);
    }

    public static inline function fold<T, R>(iter: Iterator<T>, fun: (it: T, res: R) -> R, first: R): R {
        for (it in iter) first = fun(it, first);
        return first;
    }

    public static inline function ge<T: Ord<T>>(a: Iterator<T>, b: Iterator<T>): Bool {
        return a.cmp(b) >= 0;
    }

    public static inline function geBy<T>(a: Iterator<T>, b: Iterator<T>, comparator: (T, T) -> Int): Bool {
        return a.cmpBy(b, comparator) >= 0;
    }

    public static function groupByIndex<T>(iter: Iterator<T>, toIndex: T -> Int): Array<List<T>> {
        final arr = iter.fold((it, groups: Array<List<T>>) -> groups.also(groups -> groups.getOrSet(toIndex(it), List.new).add(it)), [])
            .iterator()
            .toArray();
        for (i => group in arr) {
            if (group == null) arr[i] = new List();
        }
        return arr;
    }

    public static function group<T, R>(iter: Iterator<T>, by: T -> R, constructor: () -> Dict<R, List<T>>): Dict<R, List<T>> {
        return iter.fold((it, groups: Dict<R, List<T>>) -> groups.also(groups -> groups.getOrSet(by(it), List.new).add(it)), constructor());
    }

    public static inline function gt<T: Ord<T>>(a: Iterator<T>, b: Iterator<T>): Bool {
        return a.cmp(b) > 0;
    }

    public static inline function gtBy<T>(a: Iterator<T>, b: Iterator<T>, comparator: (T, T) -> Int): Bool {
        return a.cmpBy(b, comparator) > 0;
    }

    public static function hash<T: Hash>(iter: Iterator<T>, hasher: Hasher): Void {
        for (it in iter) it.hash(hasher);
    }

    public static function hashBy<T>(iter: Iterator<T>, hasher: Hasher, hashItem: (T, Hasher) -> Void): Void {
        for (it in iter) hashItem(it, hasher);
    }

    public static inline function le<T: Ord<T>>(a: Iterator<T>, b: Iterator<T>): Bool {
        return a.cmp(b) <= 0;
    }

    public static inline function leBy<T>(a: Iterator<T>, b: Iterator<T>, comparator: (T, T) -> Int): Bool {
        return a.cmpBy(b, comparator) <= 0;
    }

    public static inline function lt<T: Ord<T>>(a: Iterator<T>, b: Iterator<T>): Bool {
        return a.cmp(b) < 0;
    }

    public static inline function ltBy<T>(a: Iterator<T>, b: Iterator<T>, comparator: (T, T) -> Int): Bool {
        return a.cmpBy(b, comparator) < 0;
    }

    public static inline function ne<T: Eq<T>>(a: Iterator<T>, b: Iterator<T>): Bool {
        return a.neBy(b, (v1, v2) -> v1.ne(v2));
    }

    public static function neBy<T>(a: Iterator<T>, b: Iterator<T>, ne: (T, T) -> Bool): Bool {
        while (a.hasNext() && b.hasNext()) {
            if (ne(a.next(), b.next())) return true;
        }
        return a.hasNext() != b.hasNext();
    }

    public static function reduce<T>(iter: Iterator<T>, fun: (T, T) -> T): Option<T> {
        return if (iter.hasNext()) {
            Some(iter.fold(fun, iter.next()));
        } else {
            None;
        }
    }

    public static inline function toStr<T: Display>(iter: Iterator<T>, ?pre: String, ?sep: String, ?post: String): String {
        return toStrBy(iter, t -> t.toStr(), pre, sep, post);
    }

    public static inline function toRepr<T: Debug>(iter: Iterator<T>, ?pre: String, ?sep: String, ?post: String): String {
        return toStrBy(iter, t -> t.toRepr(), pre, sep, post);
    }

    public static function toStrBy<T>(iter: Iterator<T>, toStr: T -> String, pre: String = "[", sep: String = ", ", post: String = "]"): String {
        final buf = new StringBuf();
        buf.add(pre);
        if (iter.hasNext()) buf.add(toStr(iter.next()));
        for (it in iter) buf.add('$sep${toStr(it)}');
        buf.add(post);
        return buf.toString();
    }
}
