package lazylambda.core;

using datum.Core;
using lazylambda.Core;

class Collectors {
    public static inline function toArray<T>(iter: Iterator<T>): Array<T> {
        return [for (it in iter) it];
    }

    public static inline function toList<T>(iter: Iterator<T>): List<T> {
        final list = new List();
        for (it in iter) list.add(it);
        return list;
    }

    public static inline function toDict<K, V>(iter: KeyValueIterator<K, V>, constructor: () -> Dict<K, V>): Dict<K, V> {
        final dict = constructor();
        for (key => value in iter) dict[key] = value;
        return dict;
    }

    public static inline function toSet<T>(iter: Iterator<T>, constructor: () -> Set<T>): Set<T> {
        final set = constructor();
        for (it in iter) set.add(it);
        return set;
    }
}
