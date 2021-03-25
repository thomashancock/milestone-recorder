module SQLQueryMaker (
  makeSelect
) where

-- afterExtra = "WHERE"

addExtra :: [String] -> String
addExtra [] = ""
addExtra x
    | "after" `elem` x && "before" `elem` x = "WHERE (date <= ? AND date >= ?)"
    | "after" `elem` x = "WHERE date >= ?"
    | "before" `elem` x = "WHERE date <= ?"
    | otherwise = ""

commands :: [a] -> [a]
commands [] = []
commands (x:xs) = x:values xs

values :: [a] -> [a]
values [] = []
values (x:xs) = commands xs

listToTuple2 :: [a] -> (a,a)
listToTuple2 [x, y] = (x, y)

start :: [Char]
start = "SELECT * FROM test"

end :: [Char]
end = "ORDER BY date, desc"

makeSelect :: [String] -> String
makeSelect [] = start ++ " " ++ end
makeSelect x = start ++ " " ++ addExtra (commands x) ++ " " ++ end
