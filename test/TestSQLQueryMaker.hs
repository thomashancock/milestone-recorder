module TestSQLQueryMaker(
  tests
) where

import Test.HUnit

import SQLQueryMaker

-- Example queries
selectAll :: [Char]
selectAll = "SELECT * FROM test ORDER BY date, desc"

selectAfter :: [Char]
selectAfter = "SELECT * FROM test WHERE date >= ? ORDER BY date, desc"

selectBefore :: [Char]
selectBefore = "SELECT * FROM test WHERE date <= ? ORDER BY date, desc"

selectRange :: [Char]
selectRange = "SELECT * FROM test WHERE (date <= ? AND date >= ?) ORDER BY date, desc"

-- Tests
test_makeSelect_All :: Test
test_makeSelect_All = TestCase (assertEqual "makeSelect All" selectAll $ makeSelect [])

test_makeSelect_After :: Test
test_makeSelect_After = TestCase (assertEqual "makeSelect After" selectAfter $ makeSelect ["after", "2021-02-01"])

test_makeSelect_Before :: Test
test_makeSelect_Before = TestCase (assertEqual "makeSelect Before" selectBefore $ makeSelect ["before", "2021-02-01"])

test_makeSelect_Range :: Test
test_makeSelect_Range = TestCase (assertEqual "makeSelect Range" selectRange $ makeSelect ["after", "2021-01-01", "before", "2021-03-01"])

test_getArgs :: Test
test_getArgs = TestCase (assertEqual "getArgs" ["2021-01-01", "2021-03-01"] $ getArgs ["after", "2021-01-01", "before", "2021-03-01"])

tests :: Test
tests = TestList [
  TestLabel "makeSelect All" test_makeSelect_All,
  TestLabel "makeSelect After" test_makeSelect_After,
  TestLabel "makeSelect Before" test_makeSelect_Before,
  TestLabel "makeSelect Range" test_makeSelect_Range,
  TestLabel "getArgs" test_getArgs
  ]
