{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Definição de um User do jogo que contem os métodos aplicados
-- ao User em si.
module User where

import Data.text (Text)

data User = User{
    name :: String,
    troops :: Int,
    states :: [String]
} deriving (Show, Eq, Num)

-- Método para alocar tropas livres no início de um round para um User.
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado
alocaTroops :: User -> Int -> String -> IO()


-- Método para realocar tropas de um User de um estado para outro.
-- Params: User user, Int quantidade, String estado_remove, String estado_add.
-- Return: String resultado.

realocaTroops :: User -> Int -> String -> String -> IO()

-- Método para remover tropas de um User (possível ataque recebido).
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado.
removeTroops :: User -> Int -> String -> IO()