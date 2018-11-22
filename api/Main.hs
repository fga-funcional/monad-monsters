{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import GHC.Generics
import Web.Scotty
import Control.Concurrent.MVar
import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Network.Wai.Middleware.Cors
import Data.Aeson (ToJSON, FromJSON)
-- import Data.Text.Lazy as TL


data Player = Player {playerId :: Int, test :: Int} deriving(Generic, Show)
instance ToJSON Player

data Game = Game {gameId :: Int, gameName :: String, playerTurn :: Bool, player :: Player} deriving(Generic, Show)
instance ToJSON Game

main = do
    -- gameList <- []
    -- gameListVar <- newMVar gameList

    scotty 8000 $ do
        middleware simpleCors
        get "/game/:name" $ do
            name <- param "name"
            -- gs <- liftIO $ readMVar gameListVar
            -- g <- gs
            -- html $ mconcat ["<h1>Scotty, ", name, " me up!</h1>"]
            json Game {gameId = 666, gameName = name, playerTurn = True, player = Player {playerId = 10, test = 800}}


-- newGame :: String -> IO Game
-- newGame gameName =
--     return Game {gname = gameName, on = False}

    
-- data Game = Game {gname :: String, on :: Bool}

-- game :: String -> [Game] -> IO Game
-- game name (x:xs)
--     | gname x == name = return x
--     | null xs = newGame name
--     | otherwise = game name xs