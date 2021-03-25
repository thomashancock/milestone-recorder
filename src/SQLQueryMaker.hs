module SQLQueryMaker (
  makeSelect
) where

-- afterExtra = "WHERE"

-- addExtra :: [String] -> [String]
-- addExtra [] = ""
-- addExtra (x:xs)
--     | x == "after" = (head xs) ++ addExtra (tail xs)

makeSelect :: [String] -> String
makeSelect [] = "SELECT * FROM test ORDER BY date, desc"
-- makeQuery x = "SELECT * FROM test " ++ (addExtra x) ++ " ORDER BY date, desc"