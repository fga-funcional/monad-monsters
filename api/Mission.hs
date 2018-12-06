module Mission(missionCards) where

import Monster(Feature(..), getLongDescript)


data Mission = Mission {objectives :: [Feature], mname :: String } deriving (Show, Eq)

missionCards:: [(Mission, String)]
missionCards = core missions []
    where 
        core xs acc = foldl (\ acc x -> (x, getMissionDescript x) : acc) acc xs

getMissionDescript:: Mission -> String
getMissionDescript m = core "Sua missao eh conseguir um monstro que tenha " (objectives m) ""
    where 
        core desc [] (c:cs) = desc ++ (c:cs)
        core desc [x] (c:cs) = core desc [] ((c:cs)++" e "++ getLongDescript x ++ ".")
        core desc (x:xs) (c:cs) = core desc xs ((c:cs) ++ ", " ++ getLongDescript x)
        core desc (x:xs) [] = core desc xs (getLongDescript x)

missions :: [Mission]
missions =
    [
        -- Easy 3 Characteristics
        Mission [MediumLegs, BrownEyes, ButterflyEars] "Missao 01",
        Mission [MediumLegs, BlueEyes, StarEars] "Missao 02",
        Mission [MediumLegs, YellowEyes, StarEars] "Missao 03",
        Mission [LongLegs, PurpleEyes, RabbitEars] "Missao 04",
        Mission [ShortLegs, BlueEyes, NoEars] "Missao 05",

        -- Medium 4 Characteristics
        Mission [ShortLegs, ButterflyEars, BrownEyes, Furry] "Missao 06",
        Mission [ShortLegs, NoEars, BlueEyes, Spotted] "Missao 07",
        Mission [MediumLegs, StarEars, YellowEyes, Furry] "Missao 08",
        Mission [MediumLegs, NoEars, PurpleEyes, Spotted ] "Missao 09",
        Mission [MediumLegs, ButterflyEars, YellowEyes, Furry] "Missao 10",
        Mission [LongLegs, RabbitEars, PurpleEyes, Spotted] "Missao 11",
        Mission [LongLegs, StarEars, BrownEyes, Furry] "Missao 12",
        Mission [RabbitEars, PurpleEyes, Spotted, Blue] "Missao 13",
        Mission [NoEars, YellowEyes, Furry, Green] "Missao 14",
        Mission [ButterflyEars, BrownEyes, Spotted, Pink] "Missao 15",

        -- Hard 5 Characteristics
        Mission [ShortLegs, NoEars, BlueEyes, Furry, Red] "Missao 16",
        Mission [LongLegs, StarEars, BlueEyes, Spotted, Green] "Missao 17",
        Mission [LongLegs, ButterflyEars, BrownEyes,Furry, Blue] "Missao 18",
        Mission [LongLegs, RabbitEars, YellowEyes, Spotted, Pink] "Missao 19",
        Mission [ShortLegs, RabbitEars, PurpleEyes, Furry, Red] "Missao 20"
    ]
