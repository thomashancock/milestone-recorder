module Main where

import System.Environment
import Data.List (unwords)

import qualified DatabaseLocal as DB

argConcat :: [String] -> String
argConcat [] = ""
argConcat x = unwords x

add :: [String] -> String
add [] = "Add requested but no args provided"
add x = "Add requested with args: " ++ argConcat x

list :: [String] -> String
list [] = "List requested but no args provided"
list x = "List requested with args: " ++ argConcat x

procArgs :: [String] -> String
procArgs [] = "No args provided"
procArgs (x:xs)
  | x == "Add" = add xs
  | x == "List" = list xs
  | otherwise = "Invalid command: " ++ x

main = do
  DB.checkAndCreate -- Initialise the database

  -- Insert to the DB
  DB.insert "Test String 2"

  -- Get Results
  results <- DB.query 10
  mapM_ putStrLn results

  -- args <- getArgs
  -- let result = procArgs args
  -- putStrLn result