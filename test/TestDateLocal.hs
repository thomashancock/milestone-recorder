module TestDateLocal(
  tests
) where

import Test.HUnit

import DateLocal

test_showDate :: Test
test_showDate = TestCase (assertEqual "showDate" "2021-3-2" (showDate $ LocalDate (2021, 3, 2)))

test_parseDate :: Test
test_parseDate = TestCase (assertEqual "parseDate" (LocalDate (2021, 3, 2)) (parseDate "2021-3-2"))

tests :: Test
tests = TestList [
  TestLabel "showDate" test_showDate,
  TestLabel "parseDate" test_parseDate
  ]