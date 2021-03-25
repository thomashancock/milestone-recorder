module DateLocal (
  Date(..),
  showDate,
  parseDate,
  serializeDate,
  deserializeDate
) where

import Data.List.Split

data Date = Date (Int, Int, Int) deriving (Eq)

instance Show Date where
   show = showDate

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

serializeDate :: Date -> Int
serializeDate (Date (y, m, d)) = d + (100 * m) + (10000 * y)

deserializeDate :: Int -> Date
deserializeDate x = Date (y, m, d)
    where y = x `div` 10000
          m = (x `div` 100) `mod` 100
          d = x `mod` 100
