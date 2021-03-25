module SQLQueryMaker (
  makeSelect,
  getValues
) where

import Data.List (intercalate)

-- Constructes the WHERE SQL section based on the arguments 
makeWhere :: [String] -> String
makeWhere [] = ""
makeWhere [x] = "WHERE " ++ keyToQuery x
makeWhere x = "WHERE (" ++ joinQueries (keysToQueries x) ++ ")"

-- Joins queries with AND separators
joinQueries :: [String] -> String
joinQueries = intercalate " AND "

-- Converts a list of keys to queries
keysToQueries :: [String] -> [String]
keysToQueries x = [keyToQuery k | k <- x]

-- Converts a argument key to an SQL query
keyToQuery :: String -> String
keyToQuery x
  | x == "after" = "date >= ?"
  | x == "before" = "date <= ?"
  | otherwise = error $ "did not recognise key " ++ x  

-- Extracts the keys from the arguments
keys :: [a] -> [a]
keys [] = []
keys (x:xs) = x:values xs

-- Extracts the values from the arguments
values :: [a] -> [a]
values [] = []
values (x:xs) = keys xs

-- Returns the start of the SQL select command
selectStart :: [Char]
selectStart = "SELECT * FROM test"

-- Returns the end of the SQL select command
selectEnd :: [Char]
selectEnd = "ORDER BY date, desc"

-- Constructs an SQL select command from passed arguments
makeSelect :: [String] -> String
makeSelect [] = selectStart ++ " " ++ selectEnd
makeSelect x = selectStart ++ " " ++ makeWhere (keys x) ++ " " ++ selectEnd

-- Extracts the values from the passed arguments
getValues :: [String] -> [String]
getValues = values
