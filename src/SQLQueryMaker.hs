module SQLQueryMaker (
  makeSelect,
  getArgs
) where

-- Constructes the WHERE SQL section based on the arguments 
makeWhere :: [String] -> String
makeWhere [] = ""
makeWhere x
    | "after" `elem` x && "before" `elem` x = "WHERE (date <= ? AND date >= ?)"
    | "after" `elem` x = "WHERE date >= ?"
    | "before" `elem` x = "WHERE date <= ?"
    | otherwise = ""

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
getArgs :: [String] -> [String]
getArgs = values
