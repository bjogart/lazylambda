package tests;

import utest.Runner;
import utest.ui.Report;

function main(): Void {
    final runner = new Runner();

    runner.addCase(new TestConcatIterator());
    runner.addCase(new TestEmptyIterator());
    runner.addCase(new TestFilterIterator());
    runner.addCase(new TestIndexedIterator());
    runner.addCase(new TestMapIterator());
    runner.addCase(new TestRangeIterator());
    runner.addCase(new TestSlice());
    runner.addCase(new TestTerminals());
    runner.addCase(new TestZipIterator());

    Report.create(runner);
    runner.run();
}
