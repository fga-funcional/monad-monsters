{-# LANGUAGE DeriveGeneric #-}


module Card (
    Card(..),
    makeCard,
) where

import GHC.Generics
import Data.Aeson (ToJSON, FromJSON)
import Monster (Result(..), Feature(..), getDescription,rules)
import Gene (Gene(..))

data Card =
    Card { 
        kind :: Gene, 
        name :: String, 
        description :: String, 
        color :: String
    } deriving(Generic, Show, Eq)
instance ToJSON Card 
instance FromJSON Card 

deck :: [Card]
deck = cards
    where 
        cards = core genes []
        core xs acc = foldl (\ acc x -> makeCard x : acc) acc xs
        genes = 
            [
                I1,I1,I1,I1, I2,I2,I2,I2, I3,I3,I3,I3, I4,I4,I4,I4,
                O1,O1,O1, O2,O2,O2, O3,O3,O3, O4,O4,O4,
                C1,C1,C1, C2,C2,C2, C3,C3,C3, C4,C4,C4,
                T1,T1,T1,T1,T1, T2,T2,T2,T2,T2,
                P1,P1, P2,P2,P2,P2
            ] 

makeCard :: Gene -> Card
makeCard g =
    let
        info = getNameAndColor g
    in
    Card g (fst info) (getDesc g) (snd info)
    

makeDesc :: [((Gene, Gene), Result)] -> String
makeDesc xs =
    foldl (++) "" (map mountString xs)

mountString :: ((Gene, Gene), Result) -> String
mountString x =
    show (fst (fst x)) ++ " + "  ++ show (snd (fst x)) ++ " = " ++ getDescription (feature (snd x))++ "\n"

getDesc :: Gene -> String
getDesc g =
    core rules g []
    where
        core [] g acc = makeDesc acc
        core (x:xs) g acc
            | fst (fst x) == g = core xs g (x:acc)
            | snd (fst x) == g = core xs g (x:acc)
            | otherwise =  core xs g acc


getNameAndColor :: Gene -> (String, String)
getNameAndColor g =
    case g of
        C1 -> ("Cor do Pelo", "green")
        C2 -> ("Cor do Pelo", "green")
        C3 -> ("Cor do Pelo", "green")
        C4 -> ("Cor do Pelo", "green")

        I1 -> ("Cor da Iris", "red")
        I2 -> ("Cor da Iris", "red")
        I3 -> ("Cor da Iris", "red")
        I4 -> ("Cor da Iris", "red")

        O1 -> ("Tipo de Orelha", "yellow")
        O2 -> ("Tipo de Orelha", "yellow")
        O3 -> ("Tipo de Orelha", "yellow")
        O4 -> ("Tipo de Orelha", "yellow")

        P1 -> ("Tamanho do Pelo", "blue")
        P2 -> ("Tamanho do Pelo", "blue")

        T1 -> ("Tamanho da Perna", "orange")
        T2 -> ("Tamanho da Perna", "orange")

        