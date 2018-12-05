module Monster (
    Feature(..),
    Result(..),
    rules,
) where

import Gene (Gene(..), Comb(..))


data Feature =
    SmallLegs | MediumLegs | LongLegs |
    NoEars | ButterflyEars | RabbitEars | StarEars |
    BlueEyes | YellowEyes | GoldenEyes | PurpleEyes |
    NoFur | BlueFur | RedFur | GreenFur | PinkFur |
    NoSpot | BlueSpot | RedSpot | GreenSpot | PinkSpot deriving(Show, Eq)

data Result = Result { feature :: Feature, descript :: String } deriving(Show, Eq)


rules :: [(Comb, Result)]
rules =
    [
        (Comb C3 C3, Result GreenFur "Verde"),
        (Comb C3 C1, Result BlueFur "Azul"),
        (Comb C3 C2, Result RedFur "Vermelho"),
        (Comb C3 C4, Result PinkFur "Rosa")
    ]
