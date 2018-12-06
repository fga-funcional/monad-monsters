{-# LANGUAGE DeriveGeneric #-}


module Card (
    Card(..),
    makeCard,
    giveCards,
    deck,
) where


import System.Random
import GHC.Generics
import Data.Aeson (ToJSON, FromJSON)
import Monster (Result(..), Feature(..), getDescription,rules)
import Gene (Gene(..))

data Card =
    Card { 
        id :: Int,
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
        cards = core genes [] 0
        core [] acc n = acc
        core (x:xs) acc n = core xs (makeCard x n:acc) (n+1)
        genes = 
            [
                I1,I1,I1,I1, I2,I2,I2,I2, I3,I3,I3,I3, I4,I4,I4,I4,
                O1,O1,O1, O2,O2,O2, O3,O3,O3, O4,O4,O4,
                C1,C1,C1, C2,C2,C2, C3,C3,C3, C4,C4,C4,
                T1,T1,T1,T1,T1, T2,T2,T2,T2,T2,
                P1,P1, P2,P2,P2,P2
            ] 

pick :: [Card] -> IO Card
pick xs = do
    i <- randomRIO(0, length xs-1)
    return (xs !! i)

remainingDeck :: [Card] -> [Card]
remainingDeck xs = [x | x <- deck, x `notElem` xs]

remainingCards :: [Card] -> [Card] -> [Card]
remainingCards xs ys = [x | x <- xs, x `notElem` ys]

tryToCombine :: [Card] -> Maybe Feature
tryToCombine cs
    | length cs<2 = Nothing
    | length cs>2 = Nothing
    | otherwise = checkRules (kind $ head cs ) (kind $ cs !! 1)

checkRules :: Gene -> Gene -> Maybe Feature
checkRules x y = core x y rules
    where
        core x y [] = Nothing
        core x y (r:rs) = if fst (fst r) == x && snd (fst r) == y
                                then Just (feature (snd r))
                          else
                            core x y rs


giveCards :: [Card] -> Int -> Int -> IO [[Card]]
giveCards xs np nc =
    core xs np nc nc [] []
    where 
        remaining xs ys e = [x | x <- xs, x /= e, e `notElem` ys]
        core xs np nc acc_nc c_acc h_acc = do
            c <- pick xs
            if np == 0
                then return h_acc
            else
                if acc_nc == 0
                    then core (remaining xs c_acc c) (np-1) nc nc [] ((c:c_acc):h_acc) 
                else
                    core (remaining xs c_acc c) np nc (acc_nc-1) (c:c_acc) h_acc


makeCard :: Gene -> Int -> Card
makeCard g id =
    let
        info = getNameAndColor g
    in
    Card id g (fst info) (getDesc g) (snd info)
    

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

        