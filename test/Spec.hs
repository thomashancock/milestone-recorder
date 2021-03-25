import qualified TestDateLocal as TDL
import qualified TestSQLQueryMaker as TQM

import Test.HUnit

main :: IO Counts
main = do
  runTestTT TDL.tests
  runTestTT TQM.tests
