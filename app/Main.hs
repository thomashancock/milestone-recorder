module Main where

import Database.HDBC 
import Database.HDBC.Sqlite3 (connectSqlite3)

import Lib

query :: Int -> IO()
query maxId = 
    do -- Connect to DB
    conn <- connectSqlite3 "db/test.db"

    -- Run query and store in r
    r <- quickQuery' conn
        "SELECT id, desc from test where id <= ? ORDER BY id, desc"
        [toSql maxId]

    -- Convert each row into a String
    let stringRows = map convRow r
                    
    -- Print the rows out
    mapM_ putStrLn stringRows

    -- Disconnect from the database
    disconnect conn

    where convRow :: [SqlValue] -> String
          convRow [sqlId, sqlDesc] = 
              show intid ++ ": " ++ desc
              where intid = (fromSql sqlId)::Integer
                    desc = case fromSql sqlDesc of
                             Just x -> x
                             Nothing -> "NULL"
          convRow x = fail $ "Unexpected result: " ++ show x

main :: IO ()
main = query 2
