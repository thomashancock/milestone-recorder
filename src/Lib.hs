module Lib
    ( someFunc
    ) where

import qualified Data.Text.IO as T

someFunc :: IO ()
someFunc = putStrLn "someFunc"
