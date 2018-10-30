module MinhaCalculadora(
    Operand,
    Erro,
    Action,
    Operation,
    funcaoCalcular,
    -- funcaoCalculando
) where

data Operand = Int | Float

data Erro = ErroTipo1 | ErroTipo2 | ErroTipo3

data Action = Calcular | Calculando

data Operation = SomadoCom | SubtraidoDe | MultiplicadoPor | Mais | Menos | Vezes deriving(Eq)

funcaoCalcular :: Action -> Int-> Operation -> Int -> Int
funcaoCalcular a x op y
    | op == SomadoCom = x + y
    | op == SubtraidoDe = x - y
    | op == MultiplicadoPor = x * y