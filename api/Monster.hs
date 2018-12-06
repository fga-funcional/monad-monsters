module Monster (
    Feature(..),
    Result(..),
    rules,
    getDescription,
    getLongDescript
) where

import Gene (Gene(..), Comb(..))


data Feature =
    ShortLegs| MediumLegs | LongLegs |
    NoEars | ButterflyEars | RabbitEars | StarEars |
    BlueEyes | YellowEyes | BrownEyes | PurpleEyes |
    Furry | Spotted |
    Blue | Red | Green | Pink deriving(Show, Eq)

newtype Result = Result { feature :: Feature } deriving(Show, Eq)


getDescription :: Feature -> String
getDescription f = 
    case f of
        ShortLegs -> "Pequenas"
        MediumLegs -> "Medias"
        LongLegs -> "Longas"
        
        NoEars -> "Sem orelhas"
        ButterflyEars -> "Borboleta"
        RabbitEars -> "Coelho"
        StarEars -> "Estrela"

        BlueEyes -> "Azul"
        YellowEyes -> "Amarela"
        BrownEyes -> "Castanho"
        PurpleEyes -> "Roxo"

        Furry -> "Peludo"
        Spotted -> "Pelado"

        Blue -> "Azul"
        Red -> "Vermelho"
        Green -> "Verde"
        Pink -> "Rosa"

getLongDescript :: Feature -> String
getLongDescript ShortLegs = "Pernas " ++ getDescription ShortLegs
getLongDescript MediumLegs = "Pernas " ++ getDescription MediumLegs
getLongDescript LongLegs = "Pernas " ++ getDescription LongLegs

getLongDescript ButterflyEars = "Orelhas de " ++ getDescription ButterflyEars
getLongDescript RabbitEars = "Orelhas de " ++ getDescription RabbitEars
getLongDescript NoEars = getDescription NoEars
getLongDescript StarEars = "Orelhas " ++ getDescription StarEars

getLongDescript BlueEyes = "Olhos azuis"
getLongDescript YellowEyes = "Olhos amarelos "
getLongDescript BrownEyes = "Olhos castanhos"
getLongDescript PurpleEyes = "Olhos roxos"

getLongDescript Furry = "Com pelos "
getLongDescript Spotted = "Com manchas "

getLongDescript Blue = "Azuis"
getLongDescript Red = "Vermelhos"
getLongDescript Green = "Verdes"
getLongDescript Pink = "Rosas"

rules :: [((Gene, Gene), Result)]
rules =
    [
        -- Kind of Skin
        ((P1, P1), Result Furry),
        ((P1, P2), Result Furry),
        ((P2, P1), Result Furry),
        ((P2, P2), Result Spotted),
        
        -- Kinds of Legs

        ((T1, T1), Result ShortLegs),
        ((T1, T2), Result MediumLegs),
        ((T2, T1), Result MediumLegs),
        ((T2, T2), Result LongLegs),
        
        -- Eye Color.
    
        ((I1, I1), Result BrownEyes),
        ((I1, I2), Result BlueEyes),
        ((I1, I3), Result YellowEyes),
        ((I1, I4), Result PurpleEyes),

        ((I2, I1), Result BlueEyes),
        ((I2, I2), Result BlueEyes),
        ((I2, I3), Result YellowEyes),
        ((I2, I4), Result PurpleEyes),        
        
        ((I3, I1), Result YellowEyes),
        ((I3, I2), Result YellowEyes),
        ((I3, I3), Result BlueEyes),
        ((I3, I4), Result BrownEyes),
        
        ((I4, I1), Result PurpleEyes),
        ((I4, I2), Result PurpleEyes),
        ((I4, I3), Result BrownEyes),
        ((I4, I4), Result BrownEyes),
        
        -- Kinds of Ears.
        ((O1, O1), Result NoEars),
        ((O1, O2), Result ButterflyEars),
        ((O1, O3), Result RabbitEars),
        ((O1, O4), Result StarEars),

        ((O2, O1), Result ButterflyEars),
        ((O2, O2), Result ButterflyEars),
        ((O2, O3), Result RabbitEars),
        ((O2, O4), Result StarEars),

        ((O3, O1), Result RabbitEars),
        ((O3, O2), Result RabbitEars),
        ((O3, O4), Result NoEars),
        ((O3, O3), Result ButterflyEars),

        ((O4, O1), Result StarEars),
        ((O4, O2), Result StarEars),
        ((O4, O3), Result NoEars),
        ((O4, O4), Result NoEars),
        

        -- Color of Spots or Fur.
        ((C1, C1), Result Blue),
        ((C1, C2), Result Red),
        ((C1, C3), Result Green),
        ((C1, C4), Result Pink),
        
        ((C2, C1), Result Red),
        ((C2, C2), Result Red),
        ((C2, C3), Result Green),
        ((C2, C4), Result Pink),
        
        ((C3, C1), Result Green),
        ((C3, C2), Result Green),
        ((C3, C3), Result Red),
        ((C3, C4), Result Blue),

        ((C4, C3), Result Blue),
        ((C4, C4), Result Blue),
        ((C4, C1), Result Pink),
        ((C4, C2), Result Pink)        
    ]
