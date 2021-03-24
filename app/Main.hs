module Main where

import System.Environment

import DatabaseLocal (query)

-- main :: IO ()
-- main = query 2

procArgs :: [String] -> String
procArgs [] = "No args provided"
procArgs (x:xs)
  | x == "Add" = "Add requested"
  | x == "List" = "List requested"
  | otherwise = "Invalid command: " ++ x

main = do
  args <- getArgs
  let result = procArgs args
  putStrLn result