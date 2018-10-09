
data Gene2 = T2A | T2B
data Gene3 = T3A | T3B | T3C 
data Gene4 = T4A | T4B | T4C | T4D

data PhenoCopy = Ear | Eyes

data Card g = GeneCard { kind :: g } | PhenocopyCard { kind :: PhenoCopy }

data Mission = Mission {}