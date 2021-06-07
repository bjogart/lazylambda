package lazylambda.core;

class Shorthands {
    public static inline function iter<T>(iterable: Iterable<T>): Iterator<T> {
        return iterable.iterator();
    }

    public static inline function kvIter<K, V>(keyValueIterable: KeyValueIterable<K, V>): KeyValueIterator<K, V> {
        return keyValueIterable.keyValueIterator();
    }
}
