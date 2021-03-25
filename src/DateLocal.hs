module DateLocal (
  Date,
  showDate
) where

type Date=(Int,Int,Int)
data LocalDate = LocalDate 
  { year :: Int,
    month:: Int,
    day  :: Int
  }

-- parseDate :: String -> Date
-- parseDate s = (y,m,d)
--     where [(m,rest)] = readDec (filter (not . isSpace) s)
--           [(d,rest1)] = readDec (tail rest)
--           [(y, _)   ] = parseDate' rest1

showDate::(Int, Int, Int) -> String
showDate (y,m,d) = year ++ '-':month ++ '-':day
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
