module TestDateLocal(
  tests
) where

import Test.HUnit

import DateLocal

testDate = Date (2021, 3, 2)

test_showDate :: Test
test_showDate = TestCase (assertEqual "showDate" "2021-3-2" $ showDate testDate)

test_parseDate :: Test
test_parseDate = TestCase (assertEqual "parseDate" testDate $  parseDate "2021-3-2")

tests :: Test
tests = TestList [
  TestLabel "showDate" test_showDate,
  TestLabel "parseDate" test_parseDate
  ]