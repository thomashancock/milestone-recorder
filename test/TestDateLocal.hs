module TestDateLocal(
  tests
) where

import Test.HUnit

import DateLocal

test1 :: Test
test1 = TestCase (assertEqual "for (show 3)," "3" (show 3))

test2 :: Test
test2 = TestCase (assertEqual "str reverse" "cba" $ reverse "abc")

tests :: Test
tests = TestList [TestLabel "test1" test1, TestLabel "test2" test2]