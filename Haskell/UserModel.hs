{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Definição de um User do jogo (Humano ou bot) que contem os métodos aplicados
-- ao User em si.
module User where

import Data.text (Text)
import Data.Tuple.Select -- Utilitários para tuplas. Precisa da dependência de tuplas instalada (veja o README)

data User = User{
    name :: String,
    troops :: Int,
    states :: [(String, Int)]
} deriving (Show, Eq, Num)

-- Método para alocar tropas livres no início de um round para um User.
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado
alocaTroops :: User -> Int -> String -> User
alocaTroops usr 0 _ = usr
    | usr num estado = if()

-- Método para realocar tropas de um User de um estado para outro.
-- Params: User user, Int quantidade, String estado_remove, String estado_add.
-- Return: String resultado.

realocaTroops :: User -> Int -> String -> String -> IO()

-- Método para remover tropas de um User (possível ataque recebido).
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado.
removeTroops :: User -> Int -> String -> IO()

randomState :: [(String, Int)] -> String

randomTroops :: Int -> Int

randomPlay :: Int -> Int

-- Verifica se um User tem controle sobre um estado
-- Params: User user, String estado, [(String, Int)] estadosUsr
-- Return: Boolean resultado
possuiEstado :: User -> String -> [(String, Int)] -> Boolean
possuiEstado user estado h:t = 