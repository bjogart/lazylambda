package tests.ds;

using fount.Core;

class Obj implements IEq<Obj> implements IHash implements IOrd<Obj> implements IDisplay implements IDebug {
    public final val: Int;

    public function new(i: Int) {
        this.val = i;
    }

    public function eq(o: Obj): Bool {
        return val.eq(o.val);
    }

    public function hash(hasher: Hasher): Void {
        hasher.i32(val);
    }

    public function cmp(o: Obj): Int {
        return val.cmp(o.val);
    }

    public function toStr(): String {
        return val.toStr();
    }

    public function toRepr(): String {
        return 'Obj(${val.toRepr()})';
    }
}
