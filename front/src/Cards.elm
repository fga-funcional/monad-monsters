module Cards exposing (Card, mock)


import Array exposing (Array)

type alias Card =
    { kind : String, name : String, description : String, color : String }


mock : Array Card
mock =
    Array.fromList
    [ { kind = "Kind1", name = "Cor da Iris", description = "Descrption", color = "red" }
    , { kind = "Kind2", name = "Cor do Pelo", description = "Descrition", color = "blue" }
    , { kind = "Kind2", name = "Cor do Pelo", description = "Descrition", color = "blue" }
    , { kind = "Kind1", name = "Cor da Iris", description = "Descrption", color = "red" }
    , { kind = "Kind3", name = "Tipo de orelha", description = "Description", color = "green" }
    ]
