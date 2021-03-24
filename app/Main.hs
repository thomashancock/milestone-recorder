module Main where

import System.Environment
import Data.List (unwords)

import qualified DatabaseLocal as DB

argConcat :: [String] -> String
argConcat [] = ""
argConcat x = unwords x

add :: [String] -> IO String
add [] = do return"Add requested but no args provided"
add x = do
    return ("Add requested with args: " ++ argConcat x)

list :: [String] -> IO String
list [] = do return "List requested but no args provided"
list x = do
    return ("List requested with args: " ++ argConcat x)

procArgs :: [String] -> IO String
procArgs [] = do return "No args provided"
procArgs (x:xs) = do
  if x == "Add" then
    add xs
  else if x == "List" then
    list xs
  else
    return ("Invalid command: " ++ x)

main = do
  -- DB.checkAndCreate -- Initialise the database

  -- -- Insert to the DB
  -- DB.insert 4 "Hello Sam"
  -- -- DB.insert 2 "Test String 5"
  -- -- DB.insert 3 "Test String 6"

  -- -- Get Results
  -- results <- DB.query 10
  -- mapM_ putStrLn results

  args <- getArgs
  result <- procArgs args
  putStrLn result
