{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Definição de um User do jogo (Humano ou bot) que contem os métodos aplicados
-- ao User em si.
module User where

import Data.text (Text)
import Data.Tuple.Select -- Utilitários para tuplas. Precisa da dependência de tuplas instalada (veja o README)
import System.Random     

data User = User{
    name :: String,
    troops :: Int,
    alagoas :: Int,
    bahia:: Int,
    ceara:: Int,
    maranhao:: Int,
    paraiba:: Int,
    pernambuco:: Int,
    piaui:: Int,
    riograndedonorte:: Int,
    sergipe:: Int,
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

-- Seleciona um estado arbitrário para o Bot
-- Params: [(String, Int)] estados
-- Return: String estado
randomState :: [(String, Int)] -> String
randomState states = out where
    r <- randomRIO (1, lenght states)   -- Gera um indice aleatorio na lista
    out = sel1 (states !! r)            -- Pega a string da tupla na posição R


-- Selectiona uma quantidade arbitrária para o Bot
-- Params: Int limiteSuperior
-- Return: Int result
randomTroops :: Int -> Int
randomTroops num = out where
    out <- randomRIO (1, num)
    
-- Define uma escolha de jogada aleatória para o Bot
randomPlay :: Int -> Int

-- Verifica se um User tem controle sobre um estado
-- Params: User user, String estado, [(String, Int)] estadosUsr
-- Return: Boolean resultado
possuiEstado :: User -> String -> [(String, Int)] -> Boolean
possuiEstado user estado h:t
    | h == () = False                                         -- Fim da lista (condição de parada)
    | estado == sel1 h = True                                 -- Se o estado for igual a String da head (tupla)
    | estado != sel1 h = possuiEstado user estado t           -- Passo recursivo (user, estado, tail da lista)