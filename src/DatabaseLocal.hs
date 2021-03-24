module DatabaseLocal (
  checkAndCreate,
  insert,
  query
) where

import Database.HDBC 
import Database.HDBC.Sqlite3 (connectSqlite3)
import Control.Monad (when)

dbFile = "db/test.db"

checkAndCreate :: IO()
checkAndCreate =
    do
    conn <- connectSqlite3 dbFile

    stmt <- prepare conn "CREATE TABLE IF NOT EXISTS test (id INTEGER NOT NULL, desc VARCHAR(80))"
    r <- execute stmt []

    commit conn
    disconnect conn

insert :: Int -> String -> IO Integer
insert id entry =
    do
    conn <- connectSqlite3 dbFile

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
              where intid = (fromSql sqlId)::Integer
                    desc = case fromSql sqlDesc of
                             Just x -> x
                             Nothing -> "NULL"
          convRow x = fail $ "Unexpected result: " ++ show x