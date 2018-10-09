
data Eyes = Eyes { color :: String, eye_img :: String }
data Ears = Ears { format :: String, ear_img :: String }
data Pelage = Pelage { color :: String, bubble_colors :: String, pelage_img :: String }
data Legs = Legs { size :: String , legs_img :: String }

data Monster = Monster { eyes :: Eyes, ears :: Ears, pelage :: Pelage, legs :: Legs }

