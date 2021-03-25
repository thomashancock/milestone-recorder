module TestSQLQueryMaker(
  tests
) where

import Test.HUnit

import SQLQueryMaker

selectAll = "SELECT * FROM test ORDER BY date, desc"

test_makeSelect :: Test
test_makeSelect = TestCase (assertEqual "makeSelect" selectAll $ makeSelect [])

tests :: Test
tests = TestList [
  TestLabel "makeSelect" test_makeSelect
  ]
