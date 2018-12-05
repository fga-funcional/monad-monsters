{-# LANGUAGE DeriveGeneric #-}

module Gene (
    Gene(..),
    Comb,
) where

import GHC.Generics
import Data.Aeson (ToJSON, FromJSON)

data Gene =
    C1 | C2 | C3 | C4 | 
    I1 | I2 | I3 | I4 |
    O1 | O2 | O3 | O4 |
    P1 | P2 |
    T1 | T2 deriving(Generic, Show, Eq)
instance ToJSON Gene 
instance FromJSON Gene 

data Comb = Comb Gene Gene deriving(Show, Eq)