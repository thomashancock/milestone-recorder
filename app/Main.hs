module Main where

import System.Environment
import Data.List (unwords)

import qualified DatabaseLocal as DB

argConcat :: [String] -> String
argConcat [] = ""
argConcat x = unwords x

add :: [String] -> IO [String]
add [] = do return ["Add requested but no args provided"]
add (x:xs) = do
    let restStr = argConcat xs
    DB.insert (read x) restStr
    return ["Added " ++ x ++ " " ++ restStr]

list :: [String] -> IO [String]
list _ = DB.query 10

procArgs :: [String] -> IO [String]
procArgs [] = do return ["No args provided"]
procArgs (x:xs) = do
  if x == "Add" then
    add xs
  else if x == "List" then
    list xs
  else
    return ["Invalid command: " ++ x]

main = do
  -- Initialise the database
  DB.checkAndCreate 

  -- Process args and print result
  args <- getArgs
  result <- procArgs args
  mapM_ putStrLn result
