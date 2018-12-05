
module Card (
    Card(..),
) where

import Monster (rules)
import Gene (Gene(..))

data Card =
    Card { kind :: Gene, name :: String, description :: String, color :: String } deriving(Show, Eq)


-- makeCard :: Gene -> Card
-- makeCard g =
--     Card g name (getDesc g) (getColor g)



-- makeDesc :: [((Gene, Gene), Result)] -> String
-- makeDesc xs =
--     core xs ""
--     where
--         core [] st = st
--         core (x:xs) st =
--              fst (fst x) ++ "+"

-- getDesc :: Gene -> String
-- getDesc g =
--     core rules g []
--     where
--         core [] g = makeDesc
--         core (x:xs) g acc
--             | fst (fst x) == g = core xs g (x:acc)
--             | snd (fst x) == g = core xs g (x:acc)
--             | otherwise =  core xs g acc


-- getColor :: Gene -> String
-- getColor g =
--     case g of
--         C1 -> "green"
--         C2 -> "green"
--         C3 -> "green"
--         C4 -> "green"

--         I1 -> "red"
--         I2 -> "red"
--         I3 -> "red"
--         I4 -> "red"

--         O1 -> "yellow"
--         O2 -> "yellow"
--         O3 -> "yellow"
--         O4 -> "yellow"

--         P1 -> "blue"
--         P2 -> "blue"

--         T1 -> "orange"
--         T2 -> "orange"

        