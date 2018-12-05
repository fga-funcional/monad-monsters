module Monster (
    Feature(..),
    Result(..),
    rules,
) where

import Gene (Gene(..), Comb(..))


data Feature =
    SmallLegs | MediumLegs | LongLegs |
    NoEars | ButterflyEars | RabbitEars | StarEars |
    BlueEyes | YellowEyes | BrownEyes | PurpleEyes |
    Furry | Spotted |
    Blue | Red | Green | Pink deriving(Show, Eq)

data Result = Result { feature :: Feature, descript :: String } deriving(Show, Eq)



rules :: [((Gene, Gene), Result)]
rules =
    [
        -- Kind of Skin
        ((P1, P1), Result Furry "Peludo"),
        ((P1, P2), Result Furry "Peludo"),
        ((P2, P1), Result Furry "Peludo"),
        ((P2, P2), Result Spotted "Pelado"),
        
        -- Kinds of Legs

        ((T1, T1), Result SmallLegs "Pernas Pequenas"),
        ((T1, T2), Result MediumLegs "Pernas Medias"),
        ((T2, T1), Result MediumLegs "Pernas Medias"),
        ((T2, T2), Result LongLegs "Pernas Longas"),
        
        -- Eye Color.
    
        ((I1, I1), Result BrownEyes "Olhos Castanhos"),
        ((I1, I2), Result BlueEyes "Olhos Azuis"),
        ((I1, I3), Result YellowEyes "Olhos Amarelos"),
        ((I1, I4), Result PurpleEyes "Olhos Roxos"),

        ((I2, I1), Result BlueEyes "Olhos Azuis"),
        ((I2, I2), Result BlueEyes "Olhos Azuis"),
        ((I2, I3), Result YellowEyes "Olhos Amarelos"),
        ((I2, I4), Result PurpleEyes "Olhos Roxos"),        
        
        ((I3, I1), Result YellowEyes "Olhos Amarelos"),
        ((I3, I2), Result YellowEyes "Olhos Amarelos"),
        ((I3, I3), Result BlueEyes "Olhos Azuis"),
        ((I3, I4), Result BrownEyes "Olhos Castanhos"),
        
        ((I4, I1), Result PurpleEyes "Olhos Roxos"),
        ((I4, I2), Result PurpleEyes "Olhos Roxos"),
        ((I4, I3), Result BrownEyes "Olhos Castanhos"),
        ((I4, I4), Result BrownEyes "Olhos Castanhos"),
        
        -- Kinds of Ears.
        ((O1, O1), Result NoEars "Sem Orelhas"),
        ((O1, O2), Result ButterflyEars "Orelhas de Borboleta"),
        ((O1, O3), Result RabbitEars "Orelhas de Coelho"),
        ((O1, O4), Result StarEars "Orelhas de Estrela"),

        ((O2, O1), Result ButterflyEars "Orelhas de Borboleta"),
        ((O2, O2), Result ButterflyEars "Orelhas de Borboleta"),
        ((O2, O3), Result RabbitEars "Orelhas de Coelho"),
        ((O2, O4), Result StarEars "Orelhas de Estrela"),

        ((O3, O1), Result RabbitEars "Orelhas de Coelho"),
        ((O3, O2), Result RabbitEars "Orelhas de Coelho"),
        ((O3, O4), Result NoEars "Sem Orelhas"),
        ((O3, O3), Result ButterflyEars "Orelhas de Borboleta"),

        ((O4, O1), Result StarEars "Orelhas de Estrela"),
        ((O4, O2), Result StarEars "Orelhas de Estrela"),
        ((O4, O3), Result NoEars "Sem Orelhas"),
        ((O4, O4), Result NoEars "Sem Orelhas"),
        

        -- Color of Spots or Fur.
        ((C1, C1), Result Blue "Azul"),
        ((C1, C2), Result Red "Vermelho"),
        ((C1, C3), Result Green "Verde"),
        ((C1, C4), Result Pink "Rosa"),
        
        ((C2, C1), Result Red "Vermelho"),
        ((C2, C2), Result Red "Vermelho"),
        ((C2, C3), Result Green "Verde"),
        ((C2, C4), Result Pink "Rosa"),
        
        ((C3, C1), Result Green "Verde"),
        ((C3, C2), Result Green "Verde"),
        ((C3, C3), Result Red "Vermelho"),
        ((C3, C4), Result Blue "Azul"),

        ((C4, C3), Result Blue "Azul"),
        ((C4, C4), Result Blue "Azul"),
        ((C4, C1), Result Pink "Rosa"),
        ((C4, C2), Result Pink "Rosa")        
    ]
