{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Algoritmos where

import Data.Random
import Data.text (Text)
import Data.Tuple.Select -- Utilitários para tuplas. Precisa da dependência de tuplas instalada (veja o README)

{-
Verifica se dois estados possuem fronteira entre si
Params: String estado1, String estado2
Return: Bool resultado
-}
neighbor :: String -> String -> Bool
neighbor estado1 estado2
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
    then if( find (estado2) pb == estado2 )
        then = True
        else then = False

else if(estado1 == "pe")
    then if( find (estado2) pe == estado2 )
        then = True
        else then = False
else if(estado1 == "ba")
    then if( find (estado2) ba == estado2)
        then = True
        else then = False
else if(estado1 == "pi")
    then if( find (estado2) pi == estado2)
        then = True
        else then = False
else if(estado1 == "ma")
    then if( find (estado2) ma == estado2)
        then = True
        else then = False
else if(estado1 == "ce")
    then if( find (estado2) ce == estado2)
        then = True
        else then = False
else if(estado1 == "rn")
    then if( find (estado2) rn == estado2)
        then = True
        else then = False
else if(estado1 ==  "al")
    then if( find (estado2) rn == estado2)
        then = True
        else then = False
else if(estado1 ==  "se")
    then if( find (estado2) se == estado2)
        then = True
        else then = False
else
    then = False

-- Seleciona um estado arbitrário para o Bot
-- Return: String estado
randomState :: String
randomState = out where
    out = sample $ randomElement ["paraiba", "pernambuco", "piaui", "maranhao", "sergipe", "alagoas", "bahia", "sergipe", "riograndedonorte", "ceara"]

-- Selectiona uma quantidade arbitrária para o Bot
-- Params: Int limiteSuperior
-- Return: Int result
randomTroops :: Int -> Int
randomTroops num = out where
    r <- randomRIO (1, num)
    out = r