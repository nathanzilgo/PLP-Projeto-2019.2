{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Algoritmos where
import System.IO.Unsafe
import System.Random
-- import Data.text (Text)
-- import Data.Tuple.Select -- Utilitários para tuplas. Precisa da dependência de tuplas instalada (veja o README)

{-
Verifica se dois estados possuem fronteira entre si
Params: String estado1, String estado2
Return: Bool resultado
-}
neighbor :: String -> String -> Bool
neighbor estado1 estado2 = do
    let pb = ["riograndedonorte", "pernambuco", "ceara"]
    let pe = ["alagoas", "bahia", "paraiba", "piaui", "ceara"]
    let ba = ["sergipe", "alagoas", "pernambuco", "piaui"]
    let pi = ["maranhao", "bahia", "ceara", "pernambuco"]
    let ma = ["piaui"]
    let ce = ["riograndedonorte", "piaui", "pernambuco", "paraiba"]
    let rn = ["ceara", "paraiba"]
    let al = ["pernambuco", "sergipe", "bahia"]
    let se = ["bahia", "alagoas"]

    if(estado1 == "paraiba")
        then if((estado2 `elem` pb))
            then True
            else False

    else if(estado1 == "pernambuco")
        then if((estado2 `elem` pe))
            then True
            else False
    else if(estado1 == "bahia")
        then if((estado2 `elem` ba))
            then True
            else False
    else if(estado1 == "piaui")
        then if((estado2 `elem` pi))
            then True
            else False
    else if(estado1 == "maranhao")
        then if((estado2 `elem` ma))
            then True
            else False
    else if(estado1 == "ceara")
        then if((estado2 `elem` ce))
            then True
            else False
    else if(estado1 == "riograndedonorte")
        then if((estado2 `elem` rn))
            then True
            else False
    else if(estado1 ==  "alagoas")
        then if((estado2 `elem` al))
            then True
            else False
    else if(estado1 ==  "sergipe")
        then if((estado2 `elem` se))
            then True
            else False
    else False

-- Seleciona um estado arbitrário para o Bot
-- Return: String estado
randomState :: String
randomState = do 
    let i = getRandomInteger (0, 8)
    ["paraiba", "pernambuco", "piaui", "maranhao", "sergipe", "alagoas", "bahia", "sergipe", "riograndedonorte", "ceara"] !! i 

-- Selectiona uma quantidade arbitrária para o Bot
-- Params: Int limiteSuperior
-- Return: Int result

randomTroops :: Int -> Int
randomTroops num = do 
    getRandomInteger (1, num)

{-
Retorna um inteiro arbitrário no intervalo definido
Params: (Int low, Int high)
Return: Int randomInt
-}
getRandomInteger :: (Int,Int) -> Int
getRandomInteger (a,b) = unsafePerformIO(randomRIO (a,b)) 