module TestDateLocal(
  tests
) where

import Test.HUnit

import DateLocal

testDate = Date (2021, 3, 2)

test_show :: Test
test_show = TestCase (assertEqual "show" "2021-3-2" $ show testDate)

test_fromStr :: Test
test_fromStr = TestCase (assertEqual "fromStr" testDate $ fromStr "2021-3-2")

test_serialize :: Test
test_serialize = TestCase (assertEqual "serializeDate" 20210302 $ serialize testDate)

test_deserialize :: Test
test_deserialize = TestCase (assertEqual "deserializeDate" testDate $ deserialize 20210302)

tests :: Test
tests = TestList [
  TestLabel "show" test_show,
  TestLabel "fromStr" test_fromStr,
  TestLabel "serialisation" test_serialize,
  TestLabel "deserialisation" test_deserialize
  ]