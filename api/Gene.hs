module Gene (
    Gene(..),
    Comb(..),
) where

data Gene =
    C1 | C2 | C3 | C4 | 
    I1 | I2 | I3 | I4 |
    O1 | O2 | O3 | O4 |
    P1 | P2 |
    T1 | T2 deriving(Show, Eq)

data Comb = Comb Gene Gene deriving(Show, Eq)