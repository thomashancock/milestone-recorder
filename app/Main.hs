module Main where

import System.Environment ( getArgs )
import Data.List (unwords)
import Data.Char (toUpper)

import qualified DatabaseLocal as DB
import qualified DateLocal

argConcat :: [String] -> String
argConcat [] = ""
argConcat x = unwords x

uppercase :: String -> String
uppercase = map toUpper

add :: [String] -> IO [String]
add [] = do return ["Add requested but no args provided"]
add (x:xs) = do
    let restStr = argConcat xs
    success <- DB.insert (DateLocal.fromStr x) restStr
    if success then
      return ["Added " ++ x ++ " " ++ restStr]
    else
      return ["Unable to add " ++ x ++ " " ++ restStr]

list :: [String] -> IO [String]
list = DB.query

delete :: [String] -> IO [String]
delete [] = do return ["Delete requested but no id provided"]
delete (x:xs) = do
    let id = read x :: Int
    success <- DB.delete id
    if success then
      return ["Deleted entry with id " ++ show id]
    else
      return ["Unable to delete entry with id " ++ show id]

procArgs :: [String] -> IO [String]
procArgs [] = do return ["No args provided"]
procArgs (x:xs) = do
  let option = uppercase x
  if option == "ADD" then
    add xs
  else if option == "LIST" then
    list xs
  else if option == "DELETE" then
    delete xs
  else
    return ["Invalid command: " ++ x]

main :: IO ()
main = do
  -- Initialise the database
  DB.checkAndCreate 

  -- Process args and print result
  args <- getArgs
  result <- procArgs args
  mapM_ putStrLn result
