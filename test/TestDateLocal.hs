module TestDateLocal(
  tests
) where

import Test.HUnit

import DateLocal

testDate = Date (2021, 3, 2)

test_showDate :: Test
test_showDate = TestCase (assertEqual "showDate" "2021-3-2" $ showDate testDate)

test_showImpl :: Test
test_showImpl = TestCase (assertEqual "show" "2021-3-2" $ show testDate)

test_parseDate :: Test
test_parseDate = TestCase (assertEqual "parseDate" testDate $  parseDate "2021-3-2")

test_serializeDate :: Test
test_serializeDate = TestCase (assertEqual "serializeDate" 20210302 $ serializeDate testDate)

test_deserializeDate :: Test
test_deserializeDate = TestCase (assertEqual "deserializeDate" testDate $ deserializeDate 20210302)

tests :: Test
tests = TestList [
  TestLabel "showDate" test_showDate,
  TestLabel "show implementation" test_showImpl,
  TestLabel "parseDate" test_parseDate,
  TestLabel "serialisation" test_serializeDate,
  TestLabel "deserialisation" test_deserializeDate
  ]