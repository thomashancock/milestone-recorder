module DatabaseLocal (
  checkAndCreate,
  insert,
  query
) where

import Database.HDBC 
import Database.HDBC.Sqlite3 (connectSqlite3)
import Control.Monad (when)
import Data.Maybe (fromMaybe)

import qualified DateLocal

dbFile = "db/test.db"

checkAndCreate :: IO()
checkAndCreate =
    do
    conn <- connectSqlite3 dbFile

    stmt <- prepare conn "CREATE TABLE IF NOT EXISTS test (id INTEGER NOT NULL, desc VARCHAR(80))"
    r <- execute stmt []

    commit conn
    disconnect conn

insert :: DateLocal.Date -> String -> IO Integer
insert date entry =
    do
    conn <- connectSqlite3 dbFile

    -- Serialize date as SQLite can't store dates
    let id = DateLocal.serialize date

    stmt <- prepare conn "INSERT INTO test VALUES (?, ?)"
    result <- execute stmt [toSql (id :: Int), toSql entry]

    commit conn
    disconnect conn

    -- Return the result of the execute function
    return result

query :: Int -> IO [String]
query maxId = 
    do
    conn <- connectSqlite3 dbFile

    r <- quickQuery' conn
        "SELECT id, desc from test where id <= ? ORDER BY id, desc"
        [toSql maxId]

    -- Convert each row into a String
    let stringRows = map convRow r

    disconnect conn

    return stringRows

    where convRow :: [SqlValue] -> String
          convRow [sqlId, sqlDesc] =
              show intid ++ ": " ++ desc
              where intid = fromSql sqlId :: Integer
                    desc = fromMaybe "NULL" (fromSql sqlDesc)
          convRow x = fail $ "Unexpected result: " ++ show x