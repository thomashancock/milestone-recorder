
import qualified TestDateLocal as TDL

import Test.HUnit

main :: IO Counts
main = runTestTT TDL.tests
