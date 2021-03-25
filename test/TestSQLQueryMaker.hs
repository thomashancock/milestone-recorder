module TestSQLQueryMaker(
  tests
) where

import Test.HUnit

import SQLQueryMaker

-- Example queries
selectNoFilter :: [Char]
selectNoFilter = "SELECT * FROM test ORDER BY date, desc"

selectAfter :: [Char]
selectAfter = "SELECT * FROM test WHERE date >= ? ORDER BY date, desc"

selectBefore :: [Char]
selectBefore = "SELECT * FROM test WHERE date <= ? ORDER BY date, desc"

selectRangeBeforeFirst :: [Char]
selectRangeBeforeFirst = "SELECT * FROM test WHERE (date <= ? AND date >= ?) ORDER BY date, desc"

selectRangeAfterFirst :: [Char]
selectRangeAfterFirst = "SELECT * FROM test WHERE (date >= ? AND date <= ?) ORDER BY date, desc"

-- Tests
test_makeSelect_noFilter :: Test
test_makeSelect_noFilter = TestCase (
  assertEqual 
  "makeSelect no filter" 
  selectNoFilter $ 
  makeSelect []
  )

test_makeSelect_after :: Test
test_makeSelect_after = TestCase (
  assertEqual 
  "makeSelect after" 
  selectAfter $ 
  makeSelect ["after", "2021-02-01"]
  )

test_makeSelect_before :: Test
test_makeSelect_before = TestCase (
  assertEqual 
  "makeSelect Before" 
  selectBefore $ 
  makeSelect ["before", "2021-02-01"]
  )

test_makeSelect_rangeAfterFirst :: Test
test_makeSelect_rangeAfterFirst = TestCase (
  assertEqual 
  "makeSelect range after First" 
  selectRangeAfterFirst $ 
  makeSelect ["after", "2021-01-01", "before", "2021-03-01"]
  )

test_makeSelect_rangeBeforeFirst :: Test
test_makeSelect_rangeBeforeFirst = TestCase (
  assertEqual 
  "makeSelect range before first" 
  selectRangeBeforeFirst $ 
  makeSelect ["before", "2021-03-01", "after", "2021-01-01"]
  )

test_getValues :: Test
test_getValues = TestCase (
  assertEqual 
  "getValues" 
  ["2021-01-01", "2021-03-01"] $ 
  getValues ["after", "2021-01-01", "before", "2021-03-01"]
  )

tests :: Test
tests = TestList [
  TestLabel "makeSelect no filter" test_makeSelect_noFilter,
  TestLabel "makeSelect after" test_makeSelect_after,
  TestLabel "makeSelect before" test_makeSelect_before,
  TestLabel "makeSelect range after first" test_makeSelect_rangeAfterFirst,
  TestLabel "makeSelect range before first" test_makeSelect_rangeBeforeFirst,
  TestLabel "getArgs" test_getValues
  ]
