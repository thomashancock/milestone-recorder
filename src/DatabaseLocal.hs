module DatabaseLocal (
  checkAndCreate,
  insert,
  query,
  delete
) where

import Database.HDBC
    ( fromSql,
      toSql,
      fetchAllRows',
      SqlValue,
      Statement(execute),
      IConnection(disconnect, prepare, commit) )
import Database.HDBC.Sqlite3 (connectSqlite3)
import Control.Monad (when)
import Data.Maybe (fromMaybe)

import qualified DateLocal
import qualified SQLQueryMaker as Query

dbFile :: [Char]
dbFile = "db/test.db"

checkAndCreate :: IO()
checkAndCreate =
    do
    conn <- connectSqlite3 dbFile

    stmt <- prepare conn "CREATE TABLE IF NOT EXISTS test (_id INTEGER PRIMARY KEY, date INTEGER NOT NULL, desc VARCHAR(255))"
    r <- execute stmt []

    commit conn
    disconnect conn

insert :: DateLocal.Date -> String -> IO Bool
insert date entry =
    do
    conn <- connectSqlite3 dbFile

    -- Serialize date as SQLite can't store dates
    let sDate = DateLocal.serialize date

    stmt <- prepare conn "INSERT INTO test (date, desc) VALUES (?, ?)"
    result <- execute stmt [toSql (sDate :: Int), toSql entry]

    commit conn
    disconnect conn

    -- Return whether the operation completed succesfully
    if result == 1 then
        return True
    else
        return False

query :: [String] -> IO [String]
query args = 
    do
    conn <- connectSqlite3 dbFile

    let sqlQuery = Query.makeSelect args
    stmt <- prepare conn sqlQuery

    let values = Query.getValues args
    let dates = [DateLocal.serialize $ DateLocal.fromStr a | a <- values]
    execute stmt [toSql x | x <- dates]
    r <- fetchAllRows' stmt

    -- Convert each row into a String
    let stringRows = map convRow r

    disconnect conn

    return stringRows

    where convRow :: [SqlValue] -> String
          convRow [sqlId, sqlDate, sqlDesc] =
              show id ++ ": " ++ show date ++ " - " ++ desc
              where id = fromSql sqlId :: Int
                    date = DateLocal.deserialize (fromSql sqlDate :: Int)
                    desc = fromMaybe "NULL" (fromSql sqlDesc)
          convRow x = fail $ "Unexpected result: " ++ show x

delete :: Int -> IO Bool
delete id = 
    do
    conn <- connectSqlite3 dbFile

    stmt <- prepare conn "DELETE FROM test WHERE _id == ?"
    result <- execute stmt [toSql id]

    commit conn
    disconnect conn

    -- Return whether the operation completed succesfully
    if result == 1 then
        return True
    else
        return False