module Main where

import Lib

import DatabaseLocal (query)

main :: IO ()
main = query 2
