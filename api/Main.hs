{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import GHC.Generics
import Web.Scotty
import Control.Concurrent.MVar
import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Network.Wai.Middleware.Cors
import Data.Aeson (ToJSON, FromJSON)
import Data.List as List
import Card (Card(..), makeCard, giveCards, deck)
import Gene (Gene(..))
import Monster (Feature)
-- import Data.Text.Lazy as TL

data Player = Player {playerId :: Int, playerName :: String, playerCards :: [Card]} deriving(Generic, Show, Eq)
instance ToJSON Player

data Game = Game {
    gameId :: Int, 
    gameName :: String, 
    players :: [Player],
    waiting :: Bool
} deriving(Generic, Show, Eq)
instance ToJSON Game

data Error = Error {etype :: String, msg :: String} deriving(Generic, Show)
instance ToJSON Error


main :: IO ()
main = do
    gameList <- newMVar []

    scotty 8000 $ do
        middleware simpleCors
        
        get "/cards" $ do
            h <- liftIO hands
            json h

        get "/:game" $ do
            g <- param "game"
            gs <- liftIO $ readMVar gameList

            case getGame g gs of
                Nothing ->
                    raise "Game not found. There is no game created with this name!"
                
                Just game ->
                    json game

        get "/games/:name" $ do
            name <- param "name"
            gs <- liftIO $ readMVar gameList
            
            case validateGame name gs of
                Nothing ->
                    do
                        liftIO $ modifyMVar gameList $ \gameList' -> return (gs, True)
                        raise "This game is already running!"
                
                Just game ->
                    do
                        if game `notElem` gs then
                            liftIO $ modifyMVar gameList $ \gameList' -> return (game:gs, True)
                        else
                            liftIO $ modifyMVar gameList $ \gameList' -> return (gs, True)
                        
                        json game
        
        get "/players/:game/:player" $ do
            gameName <- param "game"
            playerName <- param "player"
            gs <- liftIO $ readMVar gameList
            -- d <- liftIO $ readMVar mainDeck
            case getGame gameName gs of
                Nothing ->
                    do
                        liftIO $ modifyMVar gameList $ \gameList' -> return (newGame:gs, True)
                        -- h <- liftIO $ hands
                        json newGame
                        where
                            -- add function to give player cards
                            newPlayer = Player 0 playerName cardMock
                            newGame = Game (gameId (head gs) + 1) gameName [newPlayer] True
                    
                Just game ->    
                    -- h <- liftIO $ hands
                    case registerPlayer game playerName of
                        Nothing ->
                            raise "This game is already in progress! Try to create a new one"
                        Just updatedGame ->
                            do
                                liftIO $ modifyMVar gameList $ \gameList' -> return (updatedGameList, True)
                                json updatedGame
                                where
                                    updatedGameList = updatedGame: List.delete game gs

        post "/cards/combine" $ do
            cs <- jsonData :: ActionM [Card]
            -- tryToCombine cs
            -- show c1
            json cs


-- tryToCombine :: [Card] -> Maybe Feature
-- tryToCombine cs = Nothing



registerPlayer :: Game -> String -> Maybe Game
registerPlayer g nick
    | nick `elem` (map playerName $ players g) = Just g
    | (length $ players g) == 2 = Nothing
    -- add function to give player cards
    | otherwise =
        -- h <- hands :: IO [[Card]]
        -- ph <- (h !! 2) :: [Card]
        Just g {players = Player (getPlayerId g) nick cardMock:players g , waiting=null $ players g}

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
            Just Game {gameId = prevId, gameName = name, players = [], waiting = True}



validateMaxPlayers :: Game -> Maybe Game
validateMaxPlayers g
    | length (players g) < 2 = Just g
    | otherwise = Nothing


gameError :: Error
gameError =
    Error {etype = "Game", msg = "Game already exists"}

gameNotFound :: Error
gameNotFound =
    Error {etype = "Game", msg = "Game not found"}


cardMock :: [Card]
cardMock =
    [
        deck !! 2,
        deck !! 7,
        deck !! 43,
        deck !! 26,
        deck !! 11
    ]


hands :: IO [[Card]]
hands = giveCards deck 2 5