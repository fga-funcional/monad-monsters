{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import GHC.Generics
import Web.Scotty
import Control.Concurrent.MVar
import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Network.Wai.Middleware.Cors
import Data.Aeson (ToJSON, FromJSON)
import Data.List as List
-- import Data.Text.Lazy as TL


data Player = Player {playerId :: Int, playerName :: String} deriving(Generic, Show, Eq)
instance ToJSON Player

data Game = Game {gameId :: Int, gameName :: String, players :: [Player]} deriving(Generic, Show, Eq)
instance ToJSON Game

data Error = Error {etype :: String, msg :: String} deriving(Generic, Show)
instance ToJSON Error


main :: IO ()
main = do
    gameList <- newMVar []

    scotty 8000 $ do
        middleware simpleCors
        
        get "/game/:name" $ do
            name <- param "name"
            gs <- liftIO $ readMVar gameList
            
            case validateGame name gs of
                Nothing ->
                    do
                        liftIO $ modifyMVar gameList $ \gameList' -> return (gs, True)
                        json gameError
                
                Just game ->
                    do
                        if game `notElem` gs then
                            liftIO $ modifyMVar gameList $ \gameList' -> return (game:gs, True)
                        else
                            liftIO $ modifyMVar gameList $ \gameList' -> return (gs, True)
                        
                        json game
        
        get "/player/:game/:player" $ do
            gameName <- param "game"
            playerName <- param "player"
            gs <- liftIO $ readMVar gameList

            case getGame gameName gs of
                Nothing ->
                    do
                        liftIO $ modifyMVar gameList $ \gameList' -> return (newGame:gs, True)
                        json newGame
                        where
                            newGame = Game (gameId (head gs) + 1) gameName [Player 0 playerName]
                    
                Just game ->
                    do
                        liftIO $ modifyMVar gameList $ \gameList' -> return (updatedGameList, True)
                        json updatedGame
                        where
                            updatedGame = registerPlayer game playerName
                            updatedGameList = updatedGame: List.delete game gs



registerPlayer :: Game -> String -> Game
registerPlayer g nick =
    -- TODO: fix player duplicates
    Game (gameId g) (gameName g) (Player{playerId = getPlayerId g, playerName = nick}:players g)


getPlayerId :: Game -> Int
getPlayerId g =
    core (players g) 0
    where
        core :: [Player] -> Int -> Int
        core (x:xs) greaterId
            | playerId x >= greaterId = core xs (playerId x) + 1
            | otherwise = core xs greaterId

        core [] greaterId = greaterId



getGame :: String -> [Game] -> Maybe Game
getGame =
    core
    where
        core name (x:xs)
            | name == gameName x = Just x
            | otherwise = core name xs

        core name [] = Nothing


validateGame :: String -> [Game] -> Maybe Game
validateGame name lst =
    core name lst 0
    where
        core :: String -> [Game] -> Int -> Maybe Game
        core name (x:xs) prevId
            | gameName x == name = validateMaxPlayers x
            | otherwise = core name xs (prevId + 1)

        core name [] prevId =
            Just Game {gameId = prevId, gameName = name, players = []}



validateMaxPlayers :: Game -> Maybe Game
validateMaxPlayers g
    | length (players g) < 2 = Just g
    | otherwise = Nothing


gameError :: Error
gameError =
    Error {etype = "Game", msg = "Game already exists"}

-- newGame :: String -> IO Game
-- newGame gameName =
--     return Game {gname = gameName, on = False}

    
-- data Game = Game {gname :: String, on :: Bool}

-- game :: String -> [Game] -> IO Game
-- game name (x:xs)
--     | gname x == name = return x
--     | null xs = newGame name
--     | otherwise = game name xs