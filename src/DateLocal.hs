module DateLocal (
  Date(..),
  showDate,
  parseDate
) where

import Data.List.Split

data Date = Date (Int, Int, Int) deriving (Eq, Show)

listToTuple3 :: [a] -> (a,a,a)
listToTuple3 [x, y, z] = (x, y, z)

parseDate :: String -> Date
parseDate s = (Date values)
    where l = splitOn "-" s
          values = listToTuple3 $ map (read::String->Int) l

showDate :: Date -> String
showDate (Date (y, m, d)) = year ++ '-':month ++ '-':day
    where year = show y
          month = show m
          day = show d

-- serializeDate::(Int, Int, Int) -> Int
-- serializeDate (y,m,d) = d + (100 * m) + (10000 * y)

-- deserializeDate::Int -> (Int, Int, Int)
-- deserializeDate x = (y,m,d)
--     where y = x / 10000
--           m = (x / 100) % 100
--           d = x % 100000
