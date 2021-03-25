module DateLocal (
  Date(..),
  fromStr,
  serialize,
  deserialize
) where

import Data.List.Split

data Date = Date (Int, Int, Int) deriving (Eq)

instance Show Date where
    show (Date (y, m, d)) = year ++ '-':month ++ '-':day
        where year = show y
              month = show m
              day = show d

listToTuple3 :: [a] -> (a,a,a)
listToTuple3 [x, y, z] = (x, y, z)

fromStr :: String -> Date
fromStr s = (Date values)
    where l = splitOn "-" s
          values = listToTuple3 $ map (read::String->Int) l

serialize :: Date -> Int
serialize (Date (y, m, d)) = d + (100 * m) + (10000 * y)

deserialize :: Int -> Date
deserialize x = Date (y, m, d)
    where y = x `div` 10000
          m = (x `div` 100) `mod` 100
          d = x `mod` 100
